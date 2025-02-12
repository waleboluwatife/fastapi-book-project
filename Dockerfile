# Use a multi-stage build for better performance
FROM python:3.10 AS builder

WORKDIR /app

# Copy only requirements first (for caching layers)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Remove default Nginx config
RUN rm /etc/nginx/sites-enabled/default

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/sites-available/nginx.conf
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

# Expose the required port (Heroku will route traffic to this)
EXPOSE 80

# Start Nginx in the foreground and manage Uvicorn separately
CMD service nginx start && uvicorn main:app --host 0.0.0.0 --port 8000
