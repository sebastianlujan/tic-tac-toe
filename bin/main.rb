#!/usr/bin/env ruby

# We detect the OS ,
# and if is linux or mac,
# shows emojis else a simple character
require 'os'
require 'pry'
require '../lib/Board.rb'
require '../lib/Emoji.rb'

class Check
  @emoji = Emoji.new
  @x = @emoji.to_emoji(@emoji.codes[:x])
  @o = @emoji.to_emoji(@emoji.codes[:o])

  def tie?(moves)
    moves == 9
  end

  def game_over?(board)
    moves = board.moves
    winner?(board) || tie?(moves)
  end

  def winner?(board)
    diagonal?(board.cell) || horizontal?(board.cell) || vertical?(board.cell)
  end

  private

  def diagonal?(board)
    return true if [board[0], board[4], board[8]].all?{ |i| i == @o || i == @x }
    return true if [board[2], board[4], board[6]].all?{ |i| i == @o || i == @x }

    false
  end

  def horizontal?(board)
    index = 0
    3.times do
      index = 0
      return true if board[index..index + 2].all?{ |i| i == @o || i == @x }

      index += 3
    end
    false
  end

  def vertical?(board)
    index = 0
    3.times do
      board_list = [board[index], board[index + 3], board[index + 6]]
      return true if board_list.all?{ |i| i == @o || i == @x }

      index += 1
    end
    false
  end
end

class Display
  def clear
    `clear`
  end

  def welcome(version)
    puts "Welcome To Tic-Tac-Toe! v#{version} m2 By Ara and Seba"
  end
end

class Main
  # testing code
  attr_accessor :version

  def initialize
    @version = 1.0
  end

  # HACK: for solving the MS.console issue:
  # probably the best safe scenario is said
  # only mac is emoji emoji_friendly, but is a falacy
  def emoji_friendly?
    OS.linux? || OS.mac?
  end

  def grid_setup(cell, index, emoji, variant = nil)
    divisor = '——-—'
    plus = '+'
    space = '    '
    base = cell[index]
    item = " #{base}  "

    if emoji_friendly?
      divisor = divisor[1..-1].to_s + '-'
      space = space[1..-1].to_s + ' '

      item = emoji.check_simple_emoji(base, variant, item)
    end

    row = "\n#{divisor}#{plus}#{divisor}#{plus}#{divisor}\n"
    [space, row, item]
  end

  # TODO: use scapes instead of spaces, needs refactor
  def show_grid(cell, index, str, emoji, variant = nil)
    space, row, item = grid_setup(cell, index, emoji, variant)
    str += cell[index].nil? ? space : item
    str += '|' unless [2, 5, 8].include? index
    str += row if [2, 5].include? index
    str
  end

  def show(cell, emoji, variant = nil)
    str = "\n"

    cell.each_with_index do |_, i|
      str = show_grid(cell, i, str, emoji, variant)
    end
    str += "\n\n"
    print str
  end

  # TODO: needs a refactor
  def show_example_position(emoji)
    # binding.pry
    number_list = ('1'.ord..'9'.ord).to_a
    emoji_list = []
    style = emoji.codes[:style]
    box = emoji.codes[:box]

    number_list.each do |base|
      if emoji_friendly?
        emoji_list << emoji.to_emoji(base, style, box)
      end
    end
    show(emoji_list, emoji, emoji.codes[:style])
  end

  def show_rules(emoji)
    enter = "\n\n"
    show_example_position(emoji)
    p "if it's been chosen, select another position"
    print "you'll know you've won if your choice appears as: #{enter}"

    if emoji_friendly?
      print "\t➡️#{' ' * 4}⬇️#{' ' * 4}↘️#{' ' * 4}↗️ #{enter}"
      print "three times in a row, e.i : #{enter}\t🔵 | 🔵 | 🔵 #{enter}"
    else
      print "\n< row >#{' ' * 4}< column >#{' ' * 4}< diagonals >#{' ' * 4}#{enter}"
      print "three times in a row, e.i : #{enter}\t  o  |  o  |  o  #{enter}"
    end
  end

  def select_player
    machine = :x
    puts 'Player, please choose: X or O'
    human = gets.chomp.downcase.to_sym
    machine = :o if human == :x
    [human, machine]
  end

  def select_rules(human, emoji)
    print "Awesome! #{human}\n Do you know the rules? [Y / N]: "
    choice = gets.chomp.downcase.to_sym
    # binding.pry
    show_rules(emoji) if choice == :n

    print "\n Good luck, Human!\n"
    # sleep(5)
  end

  # needs refactor
  def get_x(human, machine, emoji)
    (human == :x || machine == :x) && emoji_friendly? ? emoji[:x] : 'x'
  end

  def get_o(human, machine, emoji)
    (human == :o || machine == :o) && emoji_friendly? ? emoji[:o] : 'o'
  end

  # return the hexadecimal representation of my next move
  def next_move(human, machine, board, emoji)
    if board.moves.odd?
      get_x(human, machine, emoji.codes)
    else
      get_o(human, machine, emoji.codes)
    end
  end

  def valid?(position, board)
    board.cell[position - 1].nil? && position.between?(1, 9)
  end

  def play(board, check, version, emoji, display)
    display.welcome version
    human, machine = select_player

    select_rules(human, emoji)

    until check.game_over? board
      p 'Select a number between 1 - 9:'
      position = gets.chomp.to_i

      if valid?(position, board)
        board.moves += 1
        move = next_move(human, machine, board, emoji)

        board.cell[position - 1] = move
      end
      show(board.cell, emoji)
      display.clear
    end
  end
end

game = Main.new
display = Display.new
board = Board.new
emoji = Emoji.new
check = Check.new
version = game.version

# binding.pry
game.play(board, check, version, emoji, display)
