#!/bin/bash

echo "Starting FastAPI server for Biology RAG Pipeline..."

# Set model cache directory (optional)
export TRANSFORMERS_CACHE=/app/.cache

# Start Uvicorn server to serve main.py
uvicorn main:app --host 0.0.0.0 --port 8000 --reload