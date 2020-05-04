#!/usr/bin/env ruby

# We detect the OS ,
# and if is linux or mac,
# shows emojis else a simple character
require 'os'
require 'pry'
require '../lib/Board.rb'

class Emoji
  # game emoji_codes
  @emoji_codes = {
    box: 0x20e3,
    emoji_style: 0xfe0f,
    x: 0x274c,
    o: 0x1f535
  }

  
end

class Main
  # testing code
  attr_accessor :board, :moves, :version

  def initialize
    # we describe a board like an Array of 10 strings
    # @board = Array.new(9, nil)

    # Amount of moves
    @moves = 0
    # game version
    @version = 1.0
  end

  # HACK: for solving the MS.console issue:
  # probably the best safe scenario is said
  # only mac is emoji friendly, but is a falacy
  def emoji_friendly?
    OS.linux? || OS.mac?
  end

  def tie?(moves)
    moves == 9
  end

  # refactor to board.game_over?
  def game_over?(moves)
    # is game over if tie? || winner?(human) || winner?(machine)
    false || tie?(moves)
  end

  # TODO: create a gem: iremoji.gem

  # the compose variants are a supperset of the old standard
  # https://www.unicode.org/charts/PDF/U1F600.pdf

  # the new standard: non available for older terminals
  # https://unicode.org/Public/emoji/13.0/emoji-sequences.txt

  # for a reference with 16 glyphes or 15 glyphes variation
  # https://en.wikipedia.org/wiki/Variation_Selectors_(Unicode_block)

  # Simple encoding for emojis without variations  is Variations = 0
  # Emoji variation sequences that contains VS16 (U+FE0F),represent :colors
  # Emoji variation sequences that contains VS15 (U+FE0E),represent monocrome !:colors

  # emoji_codes = { box: 0x20e3, emoji_style: 0xfe0f, x: 0x247c, o: 0x1f535 }

  # Explanation of a compose variants: ie: [9]
  # ordinal: " \u{0039} -> base"
  # emoji: \u{fe0f} -> emoji_variant"
  # box: \u{20e3} -> variant"

  def to_emoji(*args)
    if args.size == 1
      [args[0].to_i].pack('U')
    else
      [args[0], args[1], args[2]].pack('U*') unless args[0].nil?
    end
  end

  def check_simple_emoji(base, variant, item)
    unless base.nil? && base.to_i < 49 && base.to_i > 57
      item = " #{to_emoji(base)} " if variant.nil?
    end
    item
  end

  def grid_setup(board, index, codes, variant = nil)
    divisor = '——-—'
    plus = '+'
    space = '    '
    base = board[index]
    item = " #{base}  "

    if emoji_friendly?
      divisor = divisor[1..-1].to_s + '-'
      space = space[1..-1].to_s + ' '

      item = check_simple_emoji(base, variant, item)
    end

    row = "\n#{divisor}#{plus}#{divisor}#{plus}#{divisor}\n"
    [space, row, item]
  end

  # TODO: use scapes instead of spaces, needs refactor
  def show_grid(board, index, str, codes, variant = nil)
    space, row, item = grid_setup(board, index, codes, variant)
    str += board[index].nil? ? space : item
    str += '|' unless [2, 5, 8].include? index
    str += row if [2, 5].include? index
    str
  end

  def show(board, code, variant = nil)
    str = "\n"
    board = board.cell
    board.each_with_index do |_, i|
      str = show_grid(board, i, str, code, variant)
    end
    str += "\n\n"
    print str
  end

  def clear
    `clear`
  end

  # TODO: needs a refactor
  def show_example_position(codes)
    number_list = ('1'.ord..'9'.ord).to_a
    emoji_list = []

    number_list.each do |base|
      emoji_list << to_emoji(base, codes[:emoji_style], codes[:box]) if emoji_friendly?
    end

    show(emoji_list, codes, codes[:emoji_style])
  end

  def show_rules(emoji_codes)
    enter = "\n\n"
    show_example_position emoji_codes
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

  def select_rules(human, emoji_codes)
    print "Awesome! #{human}\n Do you know the rules? [Y / N]: "
    choice = gets.chomp.downcase.to_sym
    show_rules(emoji_codes) if choice == :n
    print "\n Good luck, Human!\n"
    # sleep(5)
  end

  def get_x(human, machine, emoji_codes)
    (human == :x || machine == :x) && emoji_friendly? ? emoji_codes[:x] : 'x'
  end

  def get_o(human, machine, emoji_codes)
    (human == :o || machine == :o) && emoji_friendly? ? emoji_codes[:o] : 'o'
  end

  # return the hexadecimal representation of my next move
  def next_move(human, machine, move, emoji_codes)
    if move.odd?
      get_x(human, machine, emoji_codes)
    else
      get_o(human, machine, emoji_codes)
    end
  end

  def valid?(position, board)
    board.cell[position - 1].nil? && position.between?(1, 9)
  end

  # Refactor to a new class Game,
  def play(board, moves, version, emoji_codes)
    show_welcome version
    human, machine = select_player

    select_rules(human, emoji_codes)
    until game_over? moves
      p 'Select a number between 1 - 9:'
      position = gets.chomp.to_i

      if valid?(position, board)
        moves += 1
        move = next_move(human, machine, moves, emoji_codes)

        board.cell[position - 1] = move
      end
      show(board, emoji_codes)
      clear
    end
  end
end

game = Main.new
board = Board.new
emoji = Emoji.new
moves = game.moves
codes = emoji.emoji_codes
version = game.version

## binding.pry
game.play(board, moves, version, codes)
