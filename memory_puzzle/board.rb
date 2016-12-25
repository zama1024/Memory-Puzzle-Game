require_relative "card"
require "byebug"
require "colorize"

class Board
  attr_reader :grid

  def initialize(board_size = 8)
    @grid = create_grid(board_size)
    self.populate
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
        if cell.up_or_down == cell.up
          print "| ".cyan
          print "#{cell.value} ".light_red
        else
          print "|   ".cyan
        end
      end
      print "|\n".cyan
      print "#{"-" * grid.length * 4}-\n".cyan
    end
  end

  def pad_numbers(val)
    if val == nil
      return " "
    elsif val < 10
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
    self[pos].reveal
    self[pos].value
  end

  def hide(pos)
    self[pos].hide
  end

  def [](pos)
    x, y = pos
    grid[Integer(x)][Integer(y)]
  end

  def []=(pos, val)
    x, y = pos
    grid[x][y] = val
  end

end
