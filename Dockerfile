# Use a slim python base image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Copy local files
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Ensure start.sh is executable inside the container
RUN chmod +x start.sh

# Expose FastAPI port
EXPOSE 8000

# Start FastAPI server
CMD ["bash", "start.sh"]