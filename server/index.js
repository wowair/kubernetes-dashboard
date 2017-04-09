const express = require('express');
const cors = require('cors');
const graphql = require('express-graphql');
const schema = require('./schema');

const app = express();

app.use(cors());

app.use(
  '/graphql',
  graphql({
    schema,
    graphiql: (process.env.NODE_ENV || 'development') === 'development',
  })
);

app.listen(4000, () => {
  console.log('Server listening on port 4000');
});
