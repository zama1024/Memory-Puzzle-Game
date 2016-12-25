require_relative "board"
require_relative "card"
require "byebug"

class Game
  attr_reader :board
  attr_accessor :previously_guessed_position, :first_guess

  def initialize(board_size)
    @board = Board.new(board_size)
    @previously_guessed_position = []
    @first_guess = true
  end

  def self.start_game
    puts "Please enter an even number for board size: ".cyan
    board_size = Integer(gets.chomp)
    until board_size.even?
      puts "Invalid size, please enter an even number:".light_red
      board_size = Integer(gets.chomp)
    end
    game = Game.new(board_size)
    game.board.render
    game.play_loop
  end

  def play_loop
    until game_over?
      make_guess
    end
    puts "Yay! you have found all the matching cards!".light_magenta
  end

  def game_over?
    board.grid.each do |row|
      row.each do |cell|
        return false if cell.up_or_down == cell.down
      end
    end
    true
  end

  def make_guess
    if self.first_guess == true
      puts "Please insert a position guess in the format => x, y"
      pos = (gets.chomp).split(",")
      board.reveal(pos)
      board.render
      self.first_guess = false
      @previously_guessed_position = pos
    else
      puts "Please insert a position guess in the format => x, y"
      pos = (gets.chomp).split(",")
      board.reveal(pos)
      board.render
      sleep(2)
      system("clear")
      if board[pos].value != board[previously_guessed_position].value
        board.hide(pos)
        board.hide(previously_guessed_position)
      end
      board.render
      @previously_guessed_position = []
      self.first_guess = true
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  Game.start_game
end
