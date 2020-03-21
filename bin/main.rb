#!/usr/bin/env ruby

# We detect the OS ,
# and if is linux or mac,
# shows emojis else a simple character
require 'os'

# we describe a board like an Array of 10 strings
board = Array.new(9, nil)

# Amount of moves
moves = 0

# game version
version = 1.0

# game marks
mark = { x: '❌', o: '🔵' }

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

def grid_setup(board, index, mark)
  divisor = '——-—--'
  plus = '+'
  space = '     '
  item = " #{board[index]}  "

  if emoji_friendly?
    divisor = divisor[1..-2].to_s
    space = space[1..-2].to_s
    item = board[index] == to_emoji(mark)
    item += ''
  end

  row = "\n#{divisor}#{plus}#{divisor}#{plus}#{divisor}\n"
  [space, row, item]
end

# TODO: use scapes instead of spaces, needs refactor
def show_grid(board, index, str, mark)
  space, row, item = grid_setup(board, index, mark)
  str += board[index].nil? ? space : item
  str += '|' unless [2, 5, 8].include? index
  str += row if [2, 5].include? index
  str
end

def show(board, mark)
  str = "\n"
  board.each_with_index do |_, i|
    str = show_grid(board, i, str, mark)
  end
  str += "\n\n"
  print str
end

def clear
  `clear`
end

# TODO: create a gem: iremoji.gem
# Explanation of a compose variants: ie: [9]
# ordinal: " \u{0039}"
# emoji: \u{fe0f}"
# box: \u{20e3} "

# the compose variants are a supperset of the old standard
# https://www.unicode.org/charts/PDF/U1F600.pdf

# the new standard: non available for older terminals
# https://unicode.org/Public/emoji/13.0/emoji-sequences.txt

# for a reference with 16 glyphes or 15 glyphes variation
# https://en.wikipedia.org/wiki/Variation_Selectors_(Unicode_block)

# Simple encoding for emojis without variations  is Variations = 0
# Emoji variation sequences that contains VS16 (U+FE0F),represent :colors
# Emoji variation sequences that contains VS15 (U+FE0E),represent monocrome !:colors
def to_emoji(emoji_code, base, variant = nil)
  emoji = [base, emoji_code[:box], emoji_code[:emoji_style]]
  emoji[:emoji_style] -= 1 unless variant == :colors

  utf8 = variant == variant.nil? ? 'U' : 'U*'
  emoji.pack(utf8)
end

# TODO: needs a refactor
def show_example_position(mark)
  glyphs = { box: 0x20e3, emoji_style: 0xfe0f }
  number_list = ('1'.ord..'9'.ord).to_a

  emoji_list = []
  emoji_list = number_list.map(&:chr) unless emoji_friendly?
  number_list.each do |base|
    emoji_list << to_emoji(glyphs, base, :colors) if emoji_friendly?
  end
  show(emoji_list, mark)
end

def show_rules(mark)
  enter = "\n\n"
  show_example_position mark
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

def select_rules(human, mark)
  print "Awesome! #{human}\n Do you know the rules? [Y / N]: "
  choice = gets.chomp.downcase.to_sym
  show_rules(mark) if choice == :n
  print "\n Good luck, Human!\n"
  sleep(5)
end

def get_x(human, machine, mark)
  (human == :x || machine == :x) && emoji_friendly? ? mark[:x] : 'x'
end

def get_o(human, machine, mark)
  (human == :o || machine == :o) && emoji_friendly? ? mark[:o] : 'o'
end

def next_move(human, machine, move, mark)
  if move.odd?
    get_x(human, machine, mark)
  else
    get_o(human, machine, mark)
  end
end

def valid?(position, board)
  board[position - 1].nil? && position.between?(1, 9)
end

# Refactor to a new class Game,
def play(board, moves, version, mark)
  show_welcome version
  human, machine = select_player

  select_rules(human, mark)
  until game_over? moves
    p 'Select a number between 1 - 9:'
    position = gets.chomp.to_i
    if valid?(position, board)
      moves += 1
      move = next_move(human, machine, moves, mark)
      board[position - 1] = move
    end
    show(board, mark)
    clear
  end
end

play(board, moves, version, mark)
