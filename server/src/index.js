'use strict';

const express = require('express');
const path = require('path');
const PORT = process.env.PORT || 8080;
const HOST = '0.0.0.0';
const CLIENT_BUILD_PATH = path.join(__dirname, '../../client/build');
const app = express();

app.use(express.static(CLIENT_BUILD_PATH));
app.get('/api', (req, res) => {
  res.set('Content-Type', 'application/json');
  let data = {
    message: 'test'
  };
  res.send(JSON.stringify(data, null, 2));
});

app.get('*', function(request, response) {
  response.sendFile(path.join(CLIENT_BUILD_PATH, 'index.html'));
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
