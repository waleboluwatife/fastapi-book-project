# Use a multi-stage build for better performance
FROM python:3.10 AS builder

WORKDIR /app
COPY requirements.txt .
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

# Start Nginx when container runs
CMD ["nginx", "-g", "daemon off;"]

