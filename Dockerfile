# Use a multi-stage build for better performance
FROM python:3.10 AS builder

# Set the working directory
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

# Expose both Nginx (80) and FastAPI (Heroku/GitHub Actions $PORT)
EXPOSE 80
EXPOSE 8000  # Default Uvicorn port, will be overridden by Heroku/GitHub Actions

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]


