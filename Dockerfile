# Use a lightweight Python image
FROM python:3.10

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=${PORT:-8000}

# Set working directory
WORKDIR /app

# Copy dependencies separately for better caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Expose the port (Heroku ignores this, but it's good practice)
EXPOSE $PORT

# Start FastAPI with dynamic port for Heroku
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT}"]
