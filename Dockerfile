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

# Remove default Nginx config and replace with ours
RUN rm /etc/nginx/sites-enabled/default
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Copy Supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose FastAPI port
EXPOSE 80

# Start FastAPI
CMD bash -c "sed -i -e 's/\$PORT/'\"$PORT\"'/g' /etc/nginx/conf.d/default.conf && supervisord -n -c /etc/supervisor/conf.d/supervisord.conf"