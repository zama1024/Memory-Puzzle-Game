require_relative "board"
require_relative "card"

class Game

  def initialize(board_size)
    @board = Board.new(board_size)
    @previouls_guessed_position = []
  end
