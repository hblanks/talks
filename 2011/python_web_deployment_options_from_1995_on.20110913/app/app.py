#!/usr/bin/python

import commands
import sys

def get_fortune():
    return commands.getoutput('/usr/games/fortune')

def cgi_app():
    sys.stdout.write('Content-Type: text/plain\n\n%s\n' % get_fortune())

def wsgi_app(environ, start_response):
    start_response('200 OK', [('content-type', 'text/plain')])
    yield get_fortune()
