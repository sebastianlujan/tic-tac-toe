#!/usr/bin/env ruby

# We detect the OS ,
# and if is linux or mac,
# shows emojis else a simple character
require 'os'
require 'pry'
require '../lib/Board.rb'
require '../lib/Emoji.rb'

class Main
  # testing code
  attr_accessor :version

  def initialize
    @version = 1.0
  end

  # HACK: for solving the MS.console issue:
  # probably the best safe scenario is said
  # only mac is emoji friendly, but is a falacy

  def tie?(moves)
    moves == 9
  end

  # refactor to board.game_over?
  def game_over?(board)
    # is game over if tie? || winner?(human) || winner?(machine)
    moves = board.moves
    false || tie?(moves)
  end

  def grid_setup(board, index, emoji, variant = nil)
    divisor = '——-—'
    plus = '+'
    space = '    '
    base = board.cell[index]
    item = " #{base}  "

    if emoji.friendly?
      divisor = divisor[1..-1].to_s + '-'
      space = space[1..-1].to_s + ' '

      item = check_simple_emoji(base, variant, item)
    end

    row = "\n#{divisor}#{plus}#{divisor}#{plus}#{divisor}\n"
    [space, row, item]
  end

  # TODO: use scapes instead of spaces, needs refactor
  def show_grid(board, index, str, emoji, variant = nil)
    space, row, item = grid_setup(board, index, emoji, variant)
    board = board.cell
    str += board[index].nil? ? space : item
    str += '|' unless [2, 5, 8].include? index
    str += row if [2, 5].include? index
    str
  end

  def show(board, emoji, variant = nil)
    str = "\n"binding.pry
    cell = @board.cell
    each_with_index do |_, i|
      str = show_grid(board, i, str, emoji, variant)
    end
    str += "\n\n"
    print str
  end

  def clear
    `clear`
  end

  # TODO: needs a refactor
  def show_example_position(emoji)
    # binding.pry
    number_list = ('1'.ord..'9'.ord).to_a
    emoji_list = []

    number_list.each do |base|

      emoji_list << emoji.to_emoji(base, emoji.codes[:emoji_style], emoji.codes[:box]) if emoji.friendly?
    end

    show(emoji_list, emoji, emoji.codes[:emoji_style])
  end

  def show_rules(emoji)
    enter = "\n\n"
    show_example_position(emoji)
    p "if it's been chosen, select another position"
    print "you'll know you've won if your choice appears as: #{enter}"

    if emoji.friendly?
      print "\t➡️#{' ' * 4}⬇️#{' ' * 4}↘️#{' ' * 4}↗️ #{enter}"
      print "three times in a row, e.i : #{enter}\t🔵 | 🔵 | 🔵 #{enter}"
    else
      print "\n< row >#{' ' * 4}< column >#{' ' * 4}< diagonals >#{' ' * 4}#{enter}"
      print "three times in a row, e.i : #{enter}\t  o  |  o  |  o  #{enter}"
    end
  end

  def show_welcome(version)
    puts "Welcome To Tic-Tac-Toe! v#{version} m2 By Ara and Seba"
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

  # TODO It needs a refactor
  def get_x(human, machine, emoji)
    (human == :x || machine == :x) && emoji.friendly? ? emoji.codes[:x] : 'x'
  end

  def get_o(human, machine, emoji)
    (human == :o || machine == :o) && emoji.friendly? ? emoji.codes[:o] : 'o'
  end

  # return the hexadecimal representation of my next move
  def next_move(human, machine, move, emoji)
    if move.odd?
      get_x(human, machine, emoji.codes)
    else
      get_o(human, machine, emoji.codes)
    end
  end

  def valid?(position, board)
    board.cell[position - 1].nil? && position.between?(1, 9)
  end

  # Refactor to a new class Game,
  def play(board, version, emoji)
    show_welcome version
    human, machine = select_player

    select_rules(human, emoji)
    moves = board.moves

    until game_over? moves
      p 'Select a number between 1 - 9:'
      position = gets.chomp.to_i

      if valid?(position, board)
        moves += 1
        move = next_move(human, machine, moves, emoji)

        board.cell[position - 1] = move
      end
      show(board, emoji)
      clear
    end
  end
end

game = Main.new
board = Board.new
emoji = Emoji.new
version = game.version

# binding.pry
game.play(board, version, emoji)
