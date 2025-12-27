# Stage 1: Builder
FROM python:3.8-slim AS builder
WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    pkg-config \
    default-libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install  -r requirements.txt

# Copy application code
COPY . .


# Collect static files
RUN python manage.py collectstatic --noinput


# Stage 2: Final runtime image
FROM python:3.8-slim
WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy site-packages and app from builder
COPY --from=builder /usr/local /usr/local
COPY --from=builder /app /app

EXPOSE 8000

# Run migrations and start Gunicorn
CMD ["sh", "-c", "python manage.py migrate && gunicorn demo.wsgi:application --bind 0.0.0.0:8000"]

