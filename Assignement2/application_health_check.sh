#!/bin/bash

# Application Health Checker Script

APP_URL="http://localhost:8080"   # Change this to your app's URL

# Send a request and capture the HTTP status code
STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" "$APP_URL")

# Check if the status code is 200 (OK)
if [ "$STATUS_CODE" -eq 200 ]; then
    echo "✅ Application is UP (Status code: $STATUS_CODE)"
else
    echo "❌ Application is DOWN (Status code: $STATUS_CODE)"
fi
