import functions from '@google-cloud/functions-framework';

functions.http('helloHttp', (req, res) => {
  console.log(`Hello ${req.query.name || req.body.name || 'World'}!`);
  res.send(`Hello ${req.query.name || req.body.name || 'World'}!`);
});
