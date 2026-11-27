#!/usr/bin/env python3
"""Echo selected firmware headers for the Brno board desk."""
from http.server import BaseHTTPRequestHandler, HTTPServer
import sys


class EchoHeaders(BaseHTTPRequestHandler):
    def do_GET(self):
        board = self.headers.get("X-Board-Id", "-")
        rev = self.headers.get("X-Firmware-Rev", "-")
        body = f"board={board} rev={rev}\n".encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *_args):
        pass


if __name__ == "__main__":
    HTTPServer(("127.0.0.1", int(sys.argv[1])), EchoHeaders).serve_forever()
