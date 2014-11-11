var Board = function() {
  this.grid = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']];
};

Board.prototype.move = function (pos, player) {
  if (this.validMove(pos)) {
    this.grid[pos[0]][pos[1]] = player;
  }
};

Board.prototype.validMove = function (pos) {
  return this.grid[pos[0]][pos[1]] === ' ';
};

Board.prototype.isFinished = function () {
  return this.isWon() || this.isTied();
};

Board.prototype.isWon = function () {
  var triple = function (row) {
    if (row[0] === row[1] && row[1] === row[2] && row[0] !== ' ') {
      return row[0];
    }
  };

  return this.rows().concat(this.cols()).concat(this.diagonals()).some(triple);
};

Board.prototype.isTied = function () {
  return this.grid.every(function (row) {
    return row.every(function (val) {
      return val !== " ";
    });
  });
};

Board.prototype.rows = function () {
  return this.grid;
};

Board.prototype.cols = function () {
  var new_arr = [[], [], []];

  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      new_arr[i][j] = this.grid[j][i];
    }
  }

  return new_arr;
};

Board.prototype.diagonals = function () {
  return [[this.grid[0][0], this.grid[1][1], this.grid[2][2]],
          [this.grid[2][0], this.grid[1][1], this.grid[0][2]]];
};

Board.prototype.print = function () {
  console.log(this.grid.map(function (row) {
    return row.join('|');
  }).join('\n-----\n'))
};

module.exports = Board;