import datetime
from io import BytesIO
import os
import wave

import ffmpeg
import numpy as np
import stt

from engine.base import session
from tables.tables import Token, Transcript

Session = session()

# Convert audio to 16kHz sampling rate, 16-bit bit depth and mono channel
def normalize_audio(audio):
    out, err = (
        ffmpeg.input("pipe:0")
        .output(
            "pipe:1",
            f="WAV",
            acodec="pcm_s16le",
            ac=1,
            ar="16k",
            loglevel="error",
            hide_banner=None,
        )
        .run(input=audio, capture_stdout=True, capture_stderr=True)
    )
    if err:
        raise Exception(err)
    return out


# Extract raw audio data to be fed into CoquiSTT
def process_audio(file):
    with open(file, "rb") as file:
        audio = file.read()
        audio = normalize_audio(audio)
        audio = BytesIO(audio)
        with wave.open(audio) as wav:
            processed_audio = np.frombuffer(wav.readframes(wav.getnframes()), np.int16)
    return processed_audio


def generate_tokens(audio, model):
    metadata = model.sttWithMetadata(audio)
    # Get transcript with highest confidence
    transcript = metadata.transcripts[0]
    word = ""
    word_list = []
    word_start_time = 0
    # Loop through each character
    for i, token in enumerate(transcript.tokens):
        # Append character to word if it's not a space
        if token.text != " ":
            if len(word) == 0:
                # Log the start time of the new word
                word_start_time = token.start_time

            word = word + token.text
        # Word boundary is either a space or the last character in the array
        if token.text == " " or i == len(transcript.tokens) - 1:
            word_duration = token.start_time - word_start_time

            if word_duration < 0:
                word_duration = 0

            each_word = {}
            each_word["word"] = word
            each_word["start_time"] = round(word_start_time, 4)
            each_word["duration"] = round(word_duration, 4)

            word_list.append(each_word)
            # Reset
            word = ""
            word_start_time = 0

    result = {}
    result["confidence"] = transcript.confidence
    result["tokens"] = word_list
    return result


# Update transcript and tokens tables based on tokens generated from generate_tokens
def update_table(tokens, file_name):
    date_name = datetime.datetime.now().strftime("%b%Y").upper()
    if Session.query(Transcript).filter(Transcript.name.like(f"%{date_name}%")).first():
        row = (
            Session.query(Transcript).order_by(Transcript.transcript_id.desc()).first()
        )
        index = int(row.name[8:]) + 1
    else:
        index = 1
    phrase = " ".join(token["word"] for token in tokens["tokens"])
    audio_name = f"{date_name}-{str(index).zfill(4)}"
    new_transcript = Transcript(
        name=audio_name,
        full_transcript=phrase,
        audio=file_name,
        confidence=tokens["confidence"],
    )
    tokens_arr = [
        Token(
            token=token["word"],
            start_time=token["start_time"],
            duration=token["duration"],
        )
        for token in tokens["tokens"]
    ]
    new_transcript.tokens = tokens_arr
    Session.add(new_transcript)
    Session.commit()


def main():
    model_path = "model.tflite"
    scorer_path = "coqui-stt-0.9.3-models.scorer"
    model = stt.Model(model_path)
    model.enableExternalScorer(scorer_path)
    path = "audio/"
    files = os.listdir(path)
    # Convert audio in each file to 16kHz, 16-bit and mono channel, feed the converted audio to CoquiSTT
    # and update the transcript and tokens tables with obtained transcript
    for file in files:
        processed_audio = process_audio(path + file)
        tokens = generate_tokens(processed_audio, model)
        update_table(tokens, file)


if __name__ == "__main__":
    main()
