#!/usr/bin/env python

import os
import sys
sys.path.append(os.path.dirname(__file__))

from app import wsgi_app as application