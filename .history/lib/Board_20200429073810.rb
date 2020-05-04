class Board
  attr_accessor :moves, :cell

  def initialize
    @moves = 0

    # we describe a board like an Array of 10 strings
    @cell = Array.new(9, nil)
  end
end