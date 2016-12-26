require_relative "board"

class HumanPlayer
  attr_reader :board
  attr_accessor :previously_guessed_position, :first_guess

  def initialize
    @first_guess = true
    @previously_guessed_position = []
  end

  def make_guess
    if self.first_guess == true
      puts "Please insert a position guess in the format => x, y"
      pos = (gets.chomp).split(",")
      @previously_guessed_position = pos
      return pos
    else
      puts "Please insert a position guess in the format => x, y"
      pos = (gets.chomp).split(",")
      return pos
    end
  end
end
