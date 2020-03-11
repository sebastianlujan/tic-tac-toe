#!/usr/bin/env ruby
class Board
  # state refers to the winning or tied position of a game ,
  # the default state is false because is not won or tied

  attr_accessor :board, :played
  def initialize
    #@board = Array.new(9, ' ')
    @board = %w[🔵 ❌ 🔵 ❌ ❌ 🔵 ❌ 🔵 🔵]
    @played = 0
  end

  def clear
    `clear`
  end

  def show
    str = "\n"
    @board.each_with_index do |_, i|
      str += " #{@board[i]} "
      str += '|' unless [2, 5, 8].include? i
      str += "\n——-—+——-—+——-—\n" if [2, 5].include? i
    end
    str += "\n\n"
  end
end

board = Board.new
print board.show
=begin
  def tie?(player)
    #is tie when all the spaces are fill, and no one is won
    true
  end

  def win?(player)
    #win when the same choice is repeated 3 times in a row , column or diagonal
    false
  end

  def game_over?(player)
    state = tie?(player) || win?(player)
    state
  end
end

class Player
  # choice = { x , O } the user selection
  # position = index between 1 to 9
  attr_accessor :choice, :position

  def initialize
    @choice = 'x'
    @position = 1
  end

  def welcome
    puts 'Welcome To Tic-Tac-Toe! Please select Player: X or O?'
    @choice = gets.chomp
    puts "Awesome! #{@choice}"
    puts 'Rules: Select a number between 1-9 like:'
    puts '1️⃣ 2️⃣ 3️⃣'
    puts '4️⃣ 5️⃣ 6️⃣'
    puts '7️⃣ 8️⃣ 9️⃣'
    puts 'Make sure the space is available, if taken select another #'
    puts 'You will win if you have your symbol appear on / \ | ----'
    puts 'Good Luck and Have Fun!'
  end

  def validate?(move)
    # this method validates the input from user
    # ensures that input is a # form 1-9
    move = move.to_i
    if move.between?(1, 9)
      true
    else
      false
    end
  end

  def to_emoji(move)
    if move == 'X'
      move = '❌'
    elsif move == 'O'
      move = '🔵'
    end
    move
  end

  def play_game(position, move, board)
    ###fill the board according to the rules
    ##if valid position show board with the changes.
    ##if board.turns.odd?
    p board.board[position - 1] = convert_to_emoji(move)
    board.turn += 1
    #board[position] = convert_to_emoji(move)
    ##else
    # move O
  end

  def solicit(board)
    # this method will request the user to insert the move
    puts 'Please select a valid number between 1-9'
    @position = gets.chomp.to_i
    if validate? @position
      puts 'Valid user move. Inserting into board.'
      play_game(@position, @choice, board)
    else
      puts "Error. #{@position} is not a valid move.
      Please insert a valid number between 1-9"
    end
  end
end


p player.welcome

class Game
  board = Board.new
  player = Player.new
  
  def start
    loop do
      p board.show
      p player.solicit(board)
      if board.tur
    end    
  end
end


=begin

def solicit_move(user_move)
  # this method will request the user to insert the move
  # it also validates that it is a valid move (follows rules)
  user_moves = user_move
  puts 'Please select a valid number between 1-9'
  puts 'Error. #{user_move} is not a valid move.
    Please insert a valid number between 1-9'
end

def move
  # this method will get the user's VALID move & store it in the cell
  user_move = gets.chomp
  # put the move inside the grid position they've chosen.
  # Here we interact tiwh the Board class.
end

def clear_board
  # anytime the user inserts a new move the old board will be cleared
  # from the Console
end

def game_status(*)
  # This method EVALUATES the status of the board. Win? Tie? Continue?
  # If the winning conditions are met then it'll return true
  # if the tie conditions are met then it'll return true for tie false for win
  # if neither of the previous conditions are met then return Continue Game
  @game_stat = game_stat
  game_stat
end

def game_over(*)
  # this method carries over the result of the evaluation made in game status
  # It will also print the result of the game status to the player
  @game_over_is = arg
  if win? game_over_is(arg)
    print "HURRAY!! You've WON WON WON!"
  elsif tie? game_over_is(arg)
    print 'Sorry Suckers! No one won! muahaha!'
  else continue game
  end
end
=end
