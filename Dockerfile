FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl ca-certificates && rm -rf /var/lib/apt/lists/*

# Installe Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Script de démarrage
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Railway fournit le port via $PORT
ENV OLLAMA_HOST=0.0.0.0:${PORT}
ENV OLLAMA_MODELS=/root/.ollama

EXPOSE 11434

CMD ["/start.sh"]
