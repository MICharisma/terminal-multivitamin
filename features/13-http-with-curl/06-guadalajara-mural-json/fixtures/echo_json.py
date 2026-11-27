#!/usr/bin/env python3
"""Accept JSON mural submissions and echo a confirmation."""
from http.server import BaseHTTPRequestHandler, HTTPServer
import json
import sys


class EchoJson(BaseHTTPRequestHandler):
    def do_POST(self):
        length = int(self.headers.get("Content-Length", 0))
        raw = self.rfile.read(length)
        try:
            payload = json.loads(raw.decode("utf-8"))
        except json.JSONDecodeError:
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b'{"ok":false}\n')
            return
        reply = {
            "ok": True,
            "title": payload.get("title", ""),
            "district": payload.get("district", ""),
            "panels": payload.get("panels", 0),
        }
        body = (json.dumps(reply, separators=(",", ":")) + "\n").encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *_args):
        pass


if __name__ == "__main__":
    HTTPServer(("127.0.0.1", int(sys.argv[1])), EchoJson).serve_forever()
