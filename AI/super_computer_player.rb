require_relative 'tic_tac_toe_node'
#require 'debugger'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    new_node = TicTacToeNode.new(game.board,mark)

    new_node.children.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end

    new_node.children.each do |child|
            #return 'we got in'
      #debugger
      unless child.losing_node?(mark)
        return child.prev_move_pos
      end
    end

    raise 'Error. No non-losing nodes'
  end

end

if __FILE__ == $PROGRAM_NAME
  hp = HumanPlayer.new("Player")
  cp = SuperComputerPlayer.new

  TicTacToe.new(cp, hp).run
end
