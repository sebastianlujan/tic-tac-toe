#!/usr/bin/env ruby

# we describe a board like an Array of 10 strings
board = Array.new(9, '  ')

# Amount of moves
moves = 0

# game version
version = 1.0

# refactor to board.game_over?
def game_over?(moves)
  # is game over if tie? || winner?(human) || winner?(machine)
  false || moves > 9
end

def show(board)
  str = "\n"
  board.each_with_index do |_, i|
    str += " #{board[i]} "
    str += '|' unless [2, 5, 8].include? i
    str += "\n——-—+——-—+——-—\n" if [2, 5].include? i
  end
  str += "\n\n"
  print str
  p 'Select a number between 1 - 9:'
end

def clear
  `clear`
end

def show_example_position
  enter = "\n\n"
  print "\t1️⃣#{' ' * 4}2️⃣#{' ' * 4}3️⃣#{enter}"
  print "\t4️⃣#{' ' * 4}5️⃣#{' ' * 4}6️⃣#{enter}"
  print "\t7️⃣#{' ' * 4}8️⃣#{' ' * 4}9️⃣#{enter}"
end

def show_rules
  enter = "\n\n"
  show_example_position
  p "if it's been chosen, select another position"
  print "you'll know you've won if your choice appears as: #{enter}"
  print "\n➡️#{' ' * 4}⬇️#{' ' * 4}↘️#{' ' * 4}↗️ #{enter}"
  print "three times in a row, e.i : #{enter}\t🔵 | 🔵 | 🔵 #{enter}"
end

def show_welcome(version)
  puts "Welcome To Tic-Tac-Toe! v#{version} m2"
end

def select_player
  machine = :x
  puts 'Player, please choose: X or O'
  human = gets.chomp.downcase.to_sym
  machine = :o if human == :x
  [human, machine]
end

def select_rules(human)
  print "Awesome! #{human}\n Do you know the rules? [Y / N]: "
  choice = gets.chomp.downcase.to_sym
  show_rules if choice == :n
  p
  p 'Good luck, Human!'
  sleep(5)
end

def get_x(human, machine)
  '❌' if human == :x || machine == :x
end

def get_o(human, machine)
  '🔵' if human == :o || machine == :o
end

def next_move(human, machine, move)
  if move.odd?
    get_x(human, machine)
  else
    get_o(human, machine)
  end
end

# Refactor to a new class Game,
def play(board, moves, version)
  show_welcome version
  human, machine = select_player
  select_rules human

  until game_over? moves
    show board
    position = gets.chomp.to_i
    moves += 1
    board[position - 1] = next_move(human, machine, moves)
    clear
  end
end

play(board, moves, version)
