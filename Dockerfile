FROM python:3.9.10-slim

ENV PYTHONUNBUFFERED=1
WORKDIR /app
EXPOSE 8000

# Dependencias del sistema (CLAVE)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libpq-dev \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Dependencias Python
COPY pyproject.toml poetry.lock ./

COPY poetry.lock pyproject.toml ./

RUN pip install --upgrade pip && \
    pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install --without dev --no-root

# Código
COPY . .

CMD sh -c "alembic upgrade head && uvicorn app.main:app --host 0.0.0.0 --port 8000"