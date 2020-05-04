class Board
  attr_accessor :moves, :cell

      # we describe a board like an Array of 10 strings
  def initialize
    @moves = 0
    @cell = Array.new(9, nil)
  end
end