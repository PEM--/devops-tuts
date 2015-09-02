#!/bin/bash
METEOR_SETTINGS=$(cat /etc/meteor/settings.json) pm2 start -s --no-daemon --no-vizion main.js
