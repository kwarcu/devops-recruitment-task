'use strict';

const express = require('express');
const PORT = process.env.PORT || 8080;
const HOST = '0.0.0.0';
const app = express();

app.get('/api', (req, res) => {
  res.set('Content-Type', 'application/json');
  let data = {
    message: 'test'
  };
  res.send(JSON.stringify(data, null, 2));
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
