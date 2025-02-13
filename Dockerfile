# Use a lightweight Python image
FROM python:3.10

# Set environment variables for better performance & compatibility
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=8000  # Default, overridden by Heroku

# Set working directory
WORKDIR /app

# Copy dependency file separately for caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Expose the application port (Heroku sets its own, but useful for local testing)
EXPOSE 8000

# Start FastAPI dynamically, using the correct port from the environment
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "$PORT"]

