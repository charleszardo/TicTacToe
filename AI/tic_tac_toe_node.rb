require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark = :o, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator_sym)
    return evaluator_sym != board.winner if board.won?
    return false if board.tied?
    if evaluator_sym == next_mover_mark #player's turn
      return children.all? {|child| child.losing_node?(evaluator_sym) }
    else                                #opponent's turn
      return children.any? {|child| child.losing_node?(evaluator_sym)}
    end
  end

  def winning_node?(evaluator_sym)
    return evaluator_sym == board.winner if board.over?
    if evaluator_sym == next_mover_mark #players's turn
      return children.any? {|child| child.winning_node?(evaluator_sym) }
    else                                #opponent's turn
      return children.all? {|child| child.winning_node?(evaluator_sym)}
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children          #test this second!
    empty_positions.map do |pos|
      test_board = @board.dup     #it is deep-duped.
      test_board[pos] = @next_mover_mark
      next_mark = (@next_mover_mark==:o ? :x : :o)

      TicTacToeNode.new(test_board, next_mark, pos)
    end
  end

  def empty_positions       #test this first!
    empty_positions = []
    3.times do |i|
      3.times do |j|
        empty_positions << [i,j] if self.board.empty?([i,j])
      end
    end
    empty_positions
  end

end
