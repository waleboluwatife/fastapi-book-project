FROM nginx:alpine

# Remove default config
RUN rm -f /etc/nginx/nginx.conf

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]