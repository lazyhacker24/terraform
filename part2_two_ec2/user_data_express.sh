#!/bin/bash
apt update -y
apt install -y nodejs npm

mkdir /home/ubuntu/express_app
cd /home/ubuntu/express_app
npm init -y
npm install express

cat <<EOF > index.js
const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('Hello from Express Frontend (port 3000)!'));
app.listen(3000, () => console.log('Express running on port 3000'));
EOF

nohup node index.js &
