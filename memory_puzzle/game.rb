require_relative "board"
require_relative "card"

class Game
  attr_reader :board
  attr_accessor :previously_guessed_position, :first_guess

  def initialize(board_size)
    @board = Board.new(board_size)
    @previously_guessed_position = []
    @first_guess = true
  end

  def make_guess
    if self.first_guess == true
      puts "Please insert a position guess in the format => x, y"
      pos = (gets.chomp).split(",")
      board.reveal([pos])
      self.first_guess == false
      @previously_guessed_position == pos
    else
      puts "Please insert a position guess in the format => x, y"
      pos = (gets.chomp).split(",")
      board.reveal([pos])
      if board[pos].value != board[previously_guessed_position].value
        board.hide(pos)
        board.hide(previously_guessed_position)
      end
    end
  end




end
