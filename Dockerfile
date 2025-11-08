FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install uv (Python package manager)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:$PATH"

# Copy project files
COPY . .

# Install Python dependencies using uv
RUN uv sync

# Expose the MCP server port (if needed)
# EXPOSE 8000

# Set the entry point to run the MCP server
ENTRYPOINT ["uv", "run", "server.py"]