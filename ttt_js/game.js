var Board = require('./board');

var Game = function(reader) {
  this._reader = reader;
  this.board = new Board();
  this.player = 'X';
};

Game.prototype.run = function () {
  while (!this.board.isFinished()) {

    this.board.print();

    if (this.makeMove()) {
      this.player = this.player === 'X' ? 'O' : 'X'
    }
  }

  if (this.board.isWon()) {
    var winner = this.player === 'X' ? 'O' : 'X';
    console.log(winner + " wins!");
  } else {
    console.log("TIE");
  }
};

Game.prototype.makeMove = function () {
  var move = this._reader.question("Where do you want to move?");

  move = move.split(',').map(function (num) {
    return parseInt(num);
  } );

  if (this.board.validMove(move)) {
    this.board.move(move, this.player);
    return true;
  } else {
    return false;
  }
};

module.exports = Game;