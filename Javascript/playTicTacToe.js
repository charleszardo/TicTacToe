var readlineSync = require('readline-sync');

var TTT = require("./ttt_js");
console.log(TTT);
var g = new TTT.Game(readlineSync);

g.run();