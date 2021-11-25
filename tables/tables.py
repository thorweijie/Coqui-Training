from sqlalchemy import Column, Float, ForeignKey, Integer, String
from sqlalchemy.orm import relationship
from engine.base import Base


class Transcript(Base):
    __tablename__ = "test_transcriptions"
    transcript_id = Column(Integer, primary_key=True)
    name = Column(String)
    full_transcript = Column(String)
    audio = Column(String(length=100))
    confidence = Column(Float)
    tokens = relationship("Token")


class Token(Base):
    __tablename__ = "test_tokens"
    token_id = Column(Integer, primary_key=True)
    transcript_id = Column(Integer, ForeignKey("test_transcriptions.transcript_id"))
    token = Column(String, default=None)
    start_time = Column(Float, default=0)
    duration = Column(Float, default=0)
