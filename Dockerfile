# Use a lightweight Python image
FROM python:3.10

# Set working directory
WORKDIR /app

# Copy dependencies separately for better caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Expose FastAPI port
EXPOSE 8000

# Start FastAPI
CMD ["bash", "-c", "gunicorn -k uvicorn.workers.UvicornWorker main:app --bind 0.0.0.0:$PORT --timeout 30"]
