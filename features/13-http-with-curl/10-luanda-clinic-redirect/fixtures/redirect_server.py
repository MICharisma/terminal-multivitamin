#!/usr/bin/env python3
"""302 from /clinic to the Luanda intake sheet."""
from http.server import BaseHTTPRequestHandler, HTTPServer
import sys

INTAKE = b"patient=maria-dos-santos ward=intake nurse=nzinga\n"


class ClinicRedirect(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path in ("/clinic", "/clinic/"):
            self.send_response(302)
            self.send_header("Location", "/wards/intake.txt")
            self.end_headers()
            return
        if self.path == "/wards/intake.txt":
            self.send_response(200)
            self.send_header("Content-Type", "text/plain; charset=utf-8")
            self.send_header("Content-Length", str(len(INTAKE)))
            self.end_headers()
            self.wfile.write(INTAKE)
            return
        self.send_response(404)
        self.end_headers()

    def log_message(self, *_args):
        pass


if __name__ == "__main__":
    HTTPServer(("127.0.0.1", int(sys.argv[1])), ClinicRedirect).serve_forever()
