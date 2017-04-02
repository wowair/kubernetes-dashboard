require('./main.css');
var logoPath = require('./logo.svg');
var Elm = require('./app/Main.elm');

var root = document.getElementById('root');

Elm.Main.embed(root, logoPath);
