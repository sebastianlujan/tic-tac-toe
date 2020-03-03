# frozen_string_literal: true
class Board
  attr_accessor :board, :state
  def initialize
    # @board = Array.new(9, ' ')
    @board = %w[🔵 ❌ 🔵 ❌ ❌ 🔵 ❌ 🔵 🔵]
  end

  def show_board
    # Displaying board
    puts
    puts " #{@board[0]}  | #{@board[1]}  | #{@board[2]} "
    puts '——-—+——-—+——-—'
    puts " #{@board[3]}  | #{@board[4]}  | #{@board[5]} "
    puts '——-—+——-—+——-—'
    puts " #{@board[6]}  | #{@board[7]}  | #{@board[8]} "
  end
end
board = Board.new
p board.show_board

class Player
  attr_accessor :player

  def initialize
    @player = '❌'
  end

  def show_welcome
    puts 'Welcome To Tic-Tac-Toe! Please select Player: X or O?'
    user_input = gets.chomp
    puts "Awesome! #{user_input}"
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

  def solicit
    # this method will request the user to insert the move
    puts 'Please select a valid number between 1-9'
    user_move = gets.chomp.to_i
    if validate? user_move
      puts 'Valid user move. Inserting into board.'
    else
      puts "Error. #{user_move} is not a valid move.
      Please insert a valid number between 1-9"
    end
  end

end

player = Player.new
p player.show_welcome

=begin

def show_welcome
  puts 'Welcome To Tic-Tac-Toe! Before you Start, Please select Player: X or O?'
  user_input = gets.chomp
  puts "Awesome! #{user_input}"
  puts 'Rules: Select a number between 1-9 like:'
  puts '1️⃣ 2️⃣ 3️⃣'
  puts '4️⃣ 5️⃣ 6️⃣'
  puts '7️⃣ 8️⃣ 9️⃣'
  puts 'Make sure the space is available, if taken select another #'
  puts 'You will win if you have your symbol appear on / \ | ----'
  puts 'Good Luck and Have Fun!'
end

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
