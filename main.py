from fastapi import FastAPI
from pydantic import BaseModel
from rag_genai import generate_answer  # Import function

app = FastAPI(
    title="Biology RAG Pipeline",
    description="Ask questions from selected chapters of OpenStax Concepts of Biology",
    version="1.0.0"
)

class QueryRequest(BaseModel):
    query: str

class QueryResponse(BaseModel):
    query: str
    answer: str

@app.post("/ask/", response_model=QueryResponse)
def ask_question(payload: QueryRequest):
    """
    POST endpoint to ask a biology question. The answer is generated using RAG pipeline.
    """
    answer = generate_answer(payload.query)
    return QueryResponse(query=payload.query, answer=answer)
