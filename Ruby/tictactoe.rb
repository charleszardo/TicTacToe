class Board
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def won?
    return true if row_check
    return true if column_check
    return true if diagonal_check
    false
  end

  def column_check
    i = 0
    while i < @board.length
      check_array = []
      @board.each do |row|
        check_array << row[i]
      end
      return true if check_array.all? {|val| val == 1} || check_array.all? {|val| val == 2}
      i += 1
    end
    false
  end

  def row_check
    return true if @board.any? do |row|
      row.all? {|val| val == 1} || row.all? {|val| val == 2}
    end
    false
  end

  def diagonal_check
    check_array =  [@board[0][0], @board[1][1], @board[2][2]]
      return true if check_array.all? {|val| val == 1} || check_array.all? {|val| val == 2}
      check_array =  [@board[0][2], @board[1][1], @board[2][0]]
      return true if check_array.all? {|val| val == 1} || check_array.all? {|val| val == 2}
    false
  end

  def winner
    if self.won?
      puts "You have won!"
    end
  end

  def full?
    @board.each do |row|
      row.each do |column|
        return false if column == 0
      end
    end
    true
  end

  def empty?(pos)
    return true if @board[pos[0]][pos[1]] == 0
    false
  end

  def place_mark(pos, mark)
    if self.empty?(pos)
      @board[pos[0]][pos[1]] = mark
    end
  end

  def create_board
     [[0,0,0],
      [0,0,0],
      [0,0,0]]
  end

  def display_board
    @board.each do |line|
      line.each do |value|
        print "x" if value == 1
        print "o" if value == 2
        print "_" if value == 0
        print " "
      end
      print "\n"
    end
  end

  def test_case(pos, mark)
    copy = Board.new
    copy.board = self.board.clone
    copy.place_mark(pos, mark)
    copy.won?
  end
end

class Game
  attr_accessor :player2
  def initialize
    @turns = 0
    @game_board = self.create_board
    @player1 = HumanPlayer.new(@game_board)
    @player2 = ComputerPlayer.new(@game_board)
    @current_player = @player1
  end

  def play
    self.display_board
    puts ""
    game_over = false
    until game_over
      valid = false
      until valid
        move = @current_player.move
        if @game_board.empty?(move)
          @game_board.place_mark(move, @current_player.mark)
          valid = true
        else
           if @current_player == @player1
             puts "\ninvalid move\n"
           end
        end
      end
      puts " "
      if @game_board.won?
        game_over = true
      elsif @game_board.full?
        puts "Cat's Game"
        game_over = true
      else
        @turns += 1
        puts "\n#{self.display_name}'s move:"
        self.display_board
        self.determine_current_player
      end

    end

    self.display_board
    puts "\nGAME OVER. #{self.display_name} wins"
  end

  def display_name
    if @current_player == @player1
      return "Human"
    else
      return "Computer"
    end
  end

  def determine_current_player
    if @turns % 2 == 1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def create_board
    Board.new
  end

  def display_board
    @game_board.display_board
  end

end

class Player

end

class HumanPlayer < Player
  attr_accessor :mark

  def initialize(board)
    @board = board
    @mark = 1
  end

  def move
    puts "\nRow?"
    row = gets.chomp.to_i
    puts "Column?"
    column = gets.chomp.to_i
    return [row, column]
  end
end

class ComputerPlayer < Player
  attr_accessor :mark

  def initialize(board)
    @mark = 2
    @board = board
  end

  def move
    if self.best_move == false
      self.random_move
    else
      self.best_move
    end
  end

  protected

  def best_move
    test_board = Marshal::load(Marshal.dump(@board))
    i = 0
    best_coords = false
    while i < 3
      j = 0
      while j < 3
        test_board.place_mark([i,j],2)
        if test_board.won?
          best_coords = [i,j]
          test_board = Marshal::load(Marshal.dump(@board))
        else
          test_board = Marshal::load(Marshal.dump(@board))
        end
        j += 1
      end
      i += 1
    end
    return best_coords
  end

  def random_move
    row = rand(3)
    col = rand(3)
    return [row, col]
  end
end

g = Game.new()
g.play()

