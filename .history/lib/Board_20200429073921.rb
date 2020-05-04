class Board
  attr_accessor :moves, :cell

  def initialize
        # Amount of moves
    @moves = 0

    # we describe a board like an Array of 9 string objects
    @cell = Array.new(9, nil)
  end
end