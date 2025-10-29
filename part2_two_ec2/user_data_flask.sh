#!/bin/bash
apt update -y
apt install -y python3 python3-pip

cat <<EOF > /home/ubuntu/flask_app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello from Flask Backend (port 5000)!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

nohup python3 /home/ubuntu/flask_app.py &
