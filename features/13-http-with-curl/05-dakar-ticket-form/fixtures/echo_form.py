#!/usr/bin/env python3
"""Echo urlencoded festival ticket posts for the Dakar box office."""
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import parse_qs
import sys


class EchoForm(BaseHTTPRequestHandler):
    def do_POST(self):
        length = int(self.headers.get("Content-Length", 0))
        raw = self.rfile.read(length).decode("utf-8")
        fields = parse_qs(raw, keep_blank_values=True)
        artist = fields.get("artist", ["-"])[0]
        night = fields.get("night", ["-"])[0]
        seats = fields.get("seats", ["-"])[0]
        body = f"artist={artist};night={night};seats={seats}\n".encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *_args):
        pass


if __name__ == "__main__":
    HTTPServer(("127.0.0.1", int(sys.argv[1])), EchoForm).serve_forever()
