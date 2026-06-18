import sys
import urllib.request
import json
from datetime import datetime

ENDPOINTS = [
    "http://service.enterprise.local/healthz",
    "http://service.enterprise.local/ready"
]

def check_services():
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{timestamp}] Starting endpoints availability check...")
    
    for url in ENDPOINTS:
        try:
            with urllib.request.urlopen(url, timeout=5) as response:
                status = response.getcode()
                if status == 200:
                    print(f"[{timestamp}] SUCCESS: {url} is up and running. Status: {status}")
                else:
                    print(f"[{timestamp}] WARNING: {url} returned unexpected status: {status}")
        except Exception as e:
            print(f"[{timestamp}] CRITICAL: Failed to connect to {url}. Error: {e}", file=sys.stderr)

if __name__ == "__main__":
    check_services()
