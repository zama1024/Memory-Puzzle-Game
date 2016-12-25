class Card
  attr_accessor :value, :up_or_down

  def initialize(value)
    @value = value
    @up_or_down = down
  end

  def down
    0
  end

  def up
    1
  end

  def hide
    self.up_or_down = down
  end

  def reveal
    self.up_or_down = up
  end

end
