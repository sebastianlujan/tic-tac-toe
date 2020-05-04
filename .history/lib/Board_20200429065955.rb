class Board
  attr_accessor :moves, :cell

  def initialize
    @moves = 0
    @cell = Array.new(9, nil)
  end