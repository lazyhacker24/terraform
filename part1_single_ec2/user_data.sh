#!/bin/bash
apt update -y
apt install -y python3 python3-pip nodejs npm git

# Flask setup
cat <<EOF > /home/ubuntu/flask_app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return 'Hello from Flask Backend on port 5000!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

nohup python3 /home/ubuntu/flask_app.py &

# Express setup
mkdir /home/ubuntu/express_app
cd /home/ubuntu/express_app
npm init -y
npm install express

cat <<EOF > index.js
const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('Hello from Express Frontend on port 3000!'));
app.listen(3000, () => console.log('Express running on port 3000'));
EOF

nohup node index.js &
