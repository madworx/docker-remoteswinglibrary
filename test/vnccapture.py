#!/usr/bin/python3

from vncdotool import api

with api.connect('127.0.0.1', 'jettehemlik') as cli:
    cli.refreshScreen()
    cli.mouseMove( 1024, 1024 )
    cli.captureScreen("output/vnc_screenshot.jpg")
