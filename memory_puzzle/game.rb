require_relative "board"
require_relative "card"
require_relative "HumanPlayer"
require "byebug"

class Game
  attr_reader :board, :player

  def initialize(board_size)
    @board = Board.new(board_size)
    @player = HumanPlayer.new
  end

  def self.start_game
    puts "Please enter an even number for board size: ".cyan
    board_size = Integer(gets.chomp)
    until board_size.even?
      puts "Invalid size, please enter an even number:".light_red
      board_size = Integer(gets.chomp)
    end
    game = Game.new(board_size)
    game.play_loop
  end

  def play_loop
    until game_over?
      board.render
      pos = player.make_guess
      board.reveal(pos)
      board.render
      if player.first_guess == false
        sleep(2)
      end
      system("clear")
      if player.first_guess == false
        if board[pos].value != board[player.previously_guessed_position].value
          board.hide(pos)
          board.hide(player.previously_guessed_position)
        end
      end
      if player.first_guess == true
        player.first_guess = false
      else
         player.first_guess = true
      end
      board.render
      system("clear")
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

end

if __FILE__ == $PROGRAM_NAME
  Game.start_game
end
