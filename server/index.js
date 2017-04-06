const express = require('express');
const graphql = require('express-graphql');
const schema = require('./schema');

const app = express();

app.use(
  '/graphql',
  graphql({
    schema,
    graphiql: (process.env.NODE_ENV || 'development') === 'development',
  })
);

app.listen(3000, () => {
  console.log('Server listening on port 3000');
});
