(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.setupBoard();
  };

  View.prototype.bindEvents = function () {
    // console.log(this.game.currentPlayer);
    var that = this;
    $("li").on("click", function () {
      // console.log(event.currentTarget);

      var $target = $(this);
      that.makeMove($target);

    });
  };

  View.prototype.makeMove = function ($square) {
    // #call playMove(pos)
    that = this;

    var idx = $("li").index($square);
    var pos = this.getPos(idx);

    if (that.game.board.isEmptyPos(pos)){
      if (that.game.currentPlayer === "x") {
        $square.addClass("clickedX");
      } else {
        $square.addClass("clickedO");
      }

      this.game.playMove(pos);

    } else {
      alert("Invalid Move");
    }

    if (this.game.isOver()) {
      if (this.game.winner()) {
        alert(this.game.winner() + " has won!");
      } else {
        alert("No One Wins!");
      }

      this.clearBoard();
      this.game = new TTT.Game();
    }


  };

  View.prototype.getPos = function (idx) {
    var row = Math.floor(idx / 3);
    var col = idx % 3;

    return [row, col];
  }

  View.prototype.clearBoard = function () {
    $("li").removeClass("clickedX clickedO");
  }

  View.prototype.setupBoard = function () {
    var $body = $("body")

    var $ul = $("<ul></ul>")
    $body.append($ul);

    var $unorderedList = $("ul");

    for (var i = 0; i < 9; i++){
      var $li = $("<li></li>");
      $unorderedList.append($li);
    };

  };
})();
