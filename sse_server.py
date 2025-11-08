#!/usr/bin/env python3
"""
SSE (Server-Sent Events) transport for China Stock MCP Server

This script starts the MCP server with SSE transport support, allowing
clients to connect via HTTP/SSE instead of stdio.
"""

import asyncio
import uvicorn
from mcp.server.fastmcp import FastMCP
from mcp.server.sse import SseServerTransport
import akshare as ak
from pandas import date_range
import json

# Import the existing server and tools
from server import mcp

async def main():
    """Start the MCP server with SSE transport"""

    # Create SSE transport
    transport = SseServerTransport(
        url_prefix="/sse",
        # Optional: Add CORS headers if needed for web clients
        # cors_origins=["http://localhost:3000", "https://your-domain.com"]
    )

    # Run the server with SSE transport
    print("Starting China Stock MCP Server with SSE transport...")
    print("SSE endpoint available at: http://localhost:8000/sse")
    print("Press Ctrl+C to stop the server")

    # Start the server
    await mcp.run(transport=transport, host="0.0.0.0", port=8000)

if __name__ == "__main__":
    asyncio.run(main())