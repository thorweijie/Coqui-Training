# Coqui-Training

This directory imports audio data and the transcript produced by CoquiSTT speech-to-text
engine into a MariaDB database. The audio data and transcription can be then imported by
frontend and modified, in order to train a voicebot. Sample audio data and sql file are
provided.

## Usage

### Setting up MariaDB database

 1. Download and install [MariaDB Server](https://mariadb.org/download/)
 2. Open HeidiSQL and run SQL file (`coqui_training.sql`)

### Using the script

1. Git clone the repository
2. Download and install [ffmpeg](https://www.ffmpeg.org/download.html)
3. Download the [acoustic model](https://github.com/coqui-ai/STT-models/releases/download/english/coqui/v0.9.3/model.tflite) and [language model](https://github.com/coqui-ai/STT-models/releases/download/english/coqui/v0.9.3/coqui-stt-0.9.3-models.scorer) files for CoquiSTT and place it in the cloned repository
4. Create a venv using python -m venv venv
5. Enter venv using venv\scripts\activate (Windows) or source venv/bin/activate (Linux)
6. Run pip install -r requirements.txt
7. Run audio_import.py