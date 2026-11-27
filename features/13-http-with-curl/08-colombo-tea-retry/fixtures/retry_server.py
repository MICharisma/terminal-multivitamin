#!/usr/bin/env python3
"""Fail twice with 503, then serve the Colombo tea lot sheet."""
from http.server import BaseHTTPRequestHandler, HTTPServer
import sys

attempts = 0


class RetryTea(BaseHTTPRequestHandler):
    def do_GET(self):
        global attempts
        attempts += 1
        if attempts < 3:
            body = b"warehouse busy\n"
            self.send_response(503)
            self.send_header("Content-Type", "text/plain; charset=utf-8")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
            return
        body = b"lot=nuwara-eliya-14 grade=pekoe\n"
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *_args):
        pass


if __name__ == "__main__":
    HTTPServer(("127.0.0.1", int(sys.argv[1])), RetryTea).serve_forever()
