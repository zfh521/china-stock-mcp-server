FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install uv (Python package manager)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# Copy project files
COPY . .

# Install Python dependencies using uv with official PyPI index
RUN /root/.local/bin/uv sync --index https://pypi.org/simple/

# Expose the MCP server port (if needed)
# EXPOSE 8000

# Set the entry point to run the MCP server
ENTRYPOINT ["/root/.local/bin/uv", "run", "server.py"]