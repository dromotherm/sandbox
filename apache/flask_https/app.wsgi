#! /usr/bin/python3
import os, sys
import logging
app_dir = os.path.dirname(__file__)
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0,app_dir)
from app import app as application
application.secret_key = '1234'
