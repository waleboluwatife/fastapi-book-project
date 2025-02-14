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

# Install Nginx and Supervisor
RUN apt-get update && apt-get install -y nginx supervisor && rm -rf /var/lib/apt/lists/*

# Expose FastAPI port
EXPOSE 8000

# Start FastAPI
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]