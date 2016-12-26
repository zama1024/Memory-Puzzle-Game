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
    board_size = Game.get_board_size
    game = Game.new(board_size)
    game.play_loop
  end

  def self.get_board_size
    puts "Please enter an even number for board size: ".cyan
    board_size = Integer(gets.chomp)

    until board_size.even?
      puts "Invalid size, please enter an even number:".light_red
      board_size = Integer(gets.chomp)
    end
    board_size
  end

  def play_loop
    until game_over?
      pos = get_move
      post_move_render(pos)
      update_board(pos)
      update_guess_number
      board.render
      system("clear")
    end
    puts "Yay! you have found all the matching cards!".light_magenta
  end

  def post_move_render(pos)
    player.previously_guessed_position = pos if player.first_guess == true
    board.reveal(pos)
    board.render
  end

  def get_move
    board.render
    player.prompt
    pos = player.get_input
    check_if_valid_position(pos)
  end

  def update_board(pos)
    if player.first_guess == false
      sleep(2)
      system("clear")
      if board[pos].value != board[player.previously_guessed_position].value
        board.hide(pos)
        board.hide(player.previously_guessed_position)
      end
    end
  end

  def update_guess_number
    if player.first_guess == true
      player.first_guess = false
    else
       player.first_guess = true
    end
  end

  def check_if_valid_position(pos)
    until board[pos].up_or_down == board[pos].down
      puts "Please enter a cell which is hidden"
      player.prompt
      pos = player.get_input
    end
    pos
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
