require('./main.css');
var Elm = require('./app/Main.elm');

var root = document.getElementById('root');

Elm.Main.embed(root);
