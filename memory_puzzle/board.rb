require_relative "card"
require "byebug"
class Board
  attr_reader :grid

  def initialize(board_size = 8)
    @grid = create_grid(board_size)
  end

  def create_grid(board_size)
    Array.new(board_size) { Array.new(board_size) { Card.new(nil) } }
  end


  def populate
    num_of_pairs = (grid.length ** 2) / 2
    sample_array = (0...num_of_pairs).to_a * 2
    randomized_sample = sample_array.shuffle
    (0...@grid.length).each do |row|
      (0...grid[row].length).each do |cell|
        grid[row][cell].value = randomized_sample[-1]
        randomized_sample.pop
      end
    end
  end

  def render
    grid.each do |row|
      row.each do |cell|
        print "| #{pad_numbers(cell.value)} "  if cell.up_or_down == cell.up
        print "|  " if cell.up_or_down == cell.down
      end
      print "|\n"
      print "-----------------------------------------\n"
    end
  end

  def pad_numbers(val)
    if val < 10
      return "0" + val.to_s
    else
      return val.to_s
    end
  end

  def won?
    grid.each do |row|
      row.each do |cell|
        false if cell.up_or_down == cell.down
      end
    end
    true
  end

  def reveal(pos)
    grid[pos].reveal
    grid[pos].value
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    grid[x][y] = val
  end

end

play_board = Board.new
play_board.populate
play_board.render
