FROM python:3.9

WORKDIR /app

COPY backend/ backend/
COPY frontend/ frontend/
COPY requirements.txt .

RUN pip install -r requirements.txt

RUN apt update && apt install -y nginx

# Copy frontend to nginx
RUN cp -r frontend/* /var/www/html/

# Nginx config to proxy API
RUN echo "server { \
    listen 80; \
    location / { root /var/www/html; index index.html; } \
    location /metrics { proxy_pass http://localhost:5000/metrics; } \
}" > /etc/nginx/sites-enabled/default

CMD service nginx start && python backend/app.py
