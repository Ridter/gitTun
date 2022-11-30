#!/usr/bin/env python
from http.server import HTTPServer, BaseHTTPRequestHandler
from functools import partial
import argparse
from urllib.parse import urlparse
import logging
import sys
import os
import requests
import ssl
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

class LogFormatter(logging.Formatter):
  '''
  Prefixing logged messages through the custom attribute 'bullet'.
  '''
  def __init__(self):
      logging.Formatter.__init__(self,'%(bullet)s %(message)s', None)

  def format(self, record):
    if record.levelno == logging.INFO:
      record.bullet = '[*]'
    elif record.levelno == logging.DEBUG:
      record.bullet = '[+]'
    elif record.levelno == logging.WARNING:
      record.bullet = '[!]'
    else:
      record.bullet = '[-]'

    return logging.Formatter.format(self, record)

class LogFormatterTimeStamp(LogFormatter):
  '''
  Prefixing logged messages through the custom attribute 'bullet'.
  '''
  def __init__(self):
      logging.Formatter.__init__(self,'[%(asctime)-15s] %(bullet)s %(message)s', None)

  def formatTime(self, record, datefmt=None):
      return LogFormatter.formatTime(self, record, datefmt="%Y-%m-%d %H:%M:%S")

def log_init(ts=False):
    # We add a StreamHandler and formatter to the root logger
    handler = logging.StreamHandler(sys.stdout)
    if not ts:
        handler.setFormatter(LogFormatter())
    else:
        handler.setFormatter(LogFormatterTimeStamp())
    logging.getLogger().addHandler(handler)
    logging.getLogger().setLevel(logging.INFO)


class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def __init__(self, target, html="", user_agent="", *args, **kwargs):
        self.target = target
        self.html = html
        self.user_agent = user_agent
        # BaseHTTPRequestHandler calls do_GET **inside** __init__ !!!
        # So we have to call super().__init__ after setting attributes.
        super().__init__(*args, **kwargs)

    def do_GET(self):
        if not self.check_ua():
            self.send_default_page()
            return
        try:
            target_url = "{target}{path}".format(target=self.target, path=self.path)
            logging.info("\n{}\nGET -> {}".format('-'*30, target_url))
            logging.debug("Req Headers:\n{}".format(self.get_headers()))
            resp = requests.get(target_url, verify=False, headers=self.get_headers(), timeout=10)
            self.send_response_only(int(resp.status_code))
            self.pass_headers(resp.headers)
            self.end_headers()
            logging.debug("Resp Headers:\n\n{}".format(resp.headers))
            logging.debug("Resp:\n\n{}\n{}\n".format(resp.text, '-'*30))
            self.wfile.write(resp.content)
        except Exception as e:
            logging.errors(e)
            self.send_default_page()

    def do_POST(self):
        if not self.check_ua():
            self.send_default_page()
            return
        content_length = int(self.headers['Content-Length'])
        body = self.rfile.read(content_length)
        target_url = "{target}{path}".format(target=self.target, path=self.path)
        try:
            resp = requests.post(target_url, verify=False, data=body, headers=self.get_headers(), timeout=10)
            logging.info("\n{}\nPOST -> {}".format('-'*30, target_url))
            logging.debug("Req Headers:\n{}".format(self.get_headers()))
            self.send_response_only(int(resp.status_code))
            self.pass_headers(resp.headers)
            self.end_headers()
            logging.debug("Resp Headers:\n{}".format(resp.headers))
            logging.debug("Resp:\n\n{}\n{}\n".format(resp.text, '-'*30))
            self.wfile.write(resp.content)
        except Exception as e:
            logging.errors(e)
            self.send_default_page()

    def send_default_page(self):
        self.send_response_only(404)
        self.end_headers()
        self.send_html()

    def send_html(self):
        html = '''<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN""http://www.w3.org/TR/html4/strict.dtd">
<HTML><HEAD><TITLE>Not Found</TITLE>
    <META HTTP-EQUIV="Content-Type" Content="text/html; charset=us-ascii"></HEAD>
<BODY><h2>Not Found</h2>
<hr><p>HTTP Error 404. The requested resource is not found.</p>
</BODY></HTML>
'''.encode('utf-8', errors='ignore')
        if self.html:
            html = self.html
        self.wfile.write(html)

    def check_ua(self):
        if "User-Agent" in self.headers:
            if self.user_agent:
                if self.user_agent != self.headers['User-Agent']:
                    return False
        return True

    def get_headers(self):
        headers = {}
        for h in self.headers:
            if h.lower() not in ['host']:
                headers[h] = self.headers[h]
        return headers

    def pass_headers(self, headers):
        for h in headers:
            if h.lower() not in ['connection', 'keep-alive', 'transfer-encoding']:
                self.send_header(h, headers[h])

def main():
    parser = argparse.ArgumentParser(add_help =True, description = "Git codespace Forwarder")
    parser.add_argument('-u' ,'--url', action='store', required= True, help='Target url to content.')
    parser.add_argument('-i' ,'--interface', action='store', default="0.0.0.0", help='Interface to bind to, default is 0.0.0.0.')
    parser.add_argument('-p' ,'--port', action='store', default=443, help='Local listening port, default is 443.')
    parser.add_argument('-html', action='store', default = '', help='Fake html page')
    parser.add_argument('-cert', action='store', default = 'server.pem', help='Local server certificate, default is server.pem.')
    parser.add_argument('-user-agent', action='store', default =None , help='Whitelist of the user-agent to connect to user server, Default: (None).')
    parser.add_argument('-ts', action='store_true', help='Adds timestamp to every logging output')
    parser.add_argument('-debug', action='store_true', help='Turn DEBUG output ON')
    if len(sys.argv)==1:
        parser.print_help()
        sys.exit(1)
    options = parser.parse_args()
    log_init(options.ts)
    if options.debug is True:
        logging.getLogger().setLevel(logging.DEBUG)
    else:
        logging.getLogger().setLevel(logging.INFO)
    target = urlparse(options.url)
    if target.scheme != 'https':
        logging.error("You need to specify a https website to connect.")
        return
    target_url = "{}://{}".format(target.scheme, target.netloc)
    html , user_agent = "", ""
    if options.html:
        if not os.path.exists(options.html):
            logging.error("{} Not found".format(options.html))
            return
        html = open(options.html, 'rb').read()
    if options.user_agent:
        user_agent = options.user_agent
    handler = partial(SimpleHTTPRequestHandler, target_url, html, user_agent)
    httpd = HTTPServer((options.interface, int(options.port)), handler)
    ssl_ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    ssl_ctx.check_hostname = False  # If set to True, only the hostname that matches the certificate will be accepted
    if not os.path.exists(options.cert):
        logging.error("No certificate file, generate it use this command: 👇\nopenssl req -new -x509 -keyout server.pem -out server.pem -days 365 -nodes\n")
        return
    ssl_ctx.load_cert_chain(certfile='server.pem')
    httpd.socket = ssl_ctx.wrap_socket(httpd.socket, server_side=True)
    logging.info("Server Start at {}:{}, target: {}".format(options.interface,options.port, options.url))
    httpd.serve_forever()
    

if __name__ == "__main__":
    main()