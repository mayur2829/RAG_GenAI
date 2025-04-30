
# 📘 RAG_GenAI: Retrieval-Augmented Generation for Biology Q&A

![RAG Architecture](https://www.ibm.com/architectures/patterns/genai-rag)

**RAG_GenAI** is a Retrieval-Augmented Generation (RAG) pipeline designed to answer biology-related questions by leveraging content from the OpenStax Concepts of Biology textbook. It integrates PDF parsing, semantic chunking, vector embedding, FAISS-based similarity search, and text generation using Hugging Face Transformers, all served through a FastAPI backend.

## 📄 Code Documentation

### main.py

```python
from fastapi import FastAPI
from pydantic import BaseModel
from rag_pipeline import generate_answer

app = FastAPI()

class QueryRequest(BaseModel):
    query: str

class QueryResponse(BaseModel):
    query: str
    answer: str

@app.post("/ask/", response_model=QueryResponse)
def ask_question(payload: QueryRequest):
    """
    Handles POST requests to /ask/ endpoint.
    Returns the generated answer for the provided query.
    """
    answer = generate_answer(payload.query)
    return QueryResponse(query=payload.query, answer=answer)
```

### rag_pipeline.py

```python
def generate_answer(query):
    """
    Generates an answer for the given query by:
    1. Retrieving relevant text chunks using FAISS.
    2. Concatenating the context.
    3. Generating a response using GPT-2 model.
    """
    context = " ".join(search_similar(query))
    prompt = f"Context: {context}\n\nQuestion: {query}\nAnswer:"
    response = llm(prompt, max_new_tokens=100, do_sample=True)
    return response[0]['generated_text']
```
