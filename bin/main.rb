# frozen_string_literal: true

def show_welcome
  puts 'Welcome To Tic-Tac-Toe! Before you Start, Please select Player: X or O?'
  user_input = get.chomp
  puts "Awesome! #{user_input}"
  puts 'Rules: Select a number between 1-9 like:'
  puts '1️⃣2️⃣3️⃣'
  puts '4️⃣5️⃣6️⃣'
  puts '7️⃣8️⃣9️⃣'
  puts 'Make sure the space is available, if taken select another #'
  puts 'You will win if you have your symbol appear on / \ | ----'
  puts 'Good Luck and Have Fun!'
end

def solicit_move
  # this method will request the user to insert the move
  # it also validates that it is a valid move (follows rules)
  @user_move = user_move
  puts 'Please select a valid number between 1-9'
  puts 'Error. #{user_move} is not a valid move.
    Please insert a valid number between 1-9'
end

def move
  # this method will get the user's VALID move & store it in the cell
  user_move = get.chomp
  # put the move inside the grid position they've chosen.
  # Here we interact tiwh the Board class.
end

def clear_board
  # anytime the user inserts a new move the old board will be cleared
  # from the Console
end

def show_board
  # board is displayed with the user's input
  puts 'Here is the new board!'
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
