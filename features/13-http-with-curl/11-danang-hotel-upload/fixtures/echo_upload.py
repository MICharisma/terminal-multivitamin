#!/usr/bin/env python3
"""Accept multipart folio uploads and echo the filename."""
from http.server import BaseHTTPRequestHandler, HTTPServer
import re
import sys


class EchoUpload(BaseHTTPRequestHandler):
    def do_POST(self):
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length)
        text = body.decode("utf-8", "replace")
        match = re.search(r'filename="([^"]+)"', text)
        name = match.group(1) if match else "unknown"
        field = "folio"
        field_match = re.search(r'name="([^"]+)"', text)
        if field_match:
            field = field_match.group(1)
        reply = f"field={field};file={name}\n".encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(reply)))
        self.end_headers()
        self.wfile.write(reply)

    def log_message(self, *_args):
        pass


if __name__ == "__main__":
    HTTPServer(("127.0.0.1", int(sys.argv[1])), EchoUpload).serve_forever()
