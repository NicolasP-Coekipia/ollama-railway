FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
  curl \
  ca-certificates \
  zstd \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://ollama.com/install.sh | sh

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV OLLAMA_MODELS=/root/.ollama
EXPOSE 11434

CMD ["/start.sh"]
