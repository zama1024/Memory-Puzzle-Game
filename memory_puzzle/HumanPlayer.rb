class HumanPlayer
  attr_accessor :previously_guessed_position, :first_guess

  def initialize
    @first_guess = true
    @previously_guessed_position = []
  end

  def prompt
    puts "Please insert a position guess in the format => x, y"
  end

  def get_input
    pos = (gets.chomp).split(",")
  end

end
