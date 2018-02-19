#!/usr/bin/env python

from sys import argv
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import json
import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BCM)
GPIO.setup(4,GPIO.IN)

class JSONServer(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()

    def do_HEAD(self):
        self.set_headers()

    def do_GET(self):
        self._set_headers()
        self.wfile.write(json.dumps({'occupied': int(not GPIO.input(4))}))

def run(server_class=HTTPServer, handler_class=JSONServer, interface='127.0.0.1', port=8000):
    server_address = (interface, port)
    httpd = server_class(server_address, handler_class)

    print 'Starting JSONServer on %s:%d...' % (interface,port)
    httpd.serve_forever()

if __name__ == '__main__':
    if len(argv) == 2:
        run(port=int(argv[1]))
    elif len(argv) == 3:
        run(interface=argv[1],port=int(argv[2]))
    else:
        run()
