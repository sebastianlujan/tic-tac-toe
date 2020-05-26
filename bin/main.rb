#!/usr/bin/env ruby

board = (1..9).to_a
moves = 1
puts 'Welcome to tic tac toe bro!'

puts 'Choose player A:'
player1 = gets.chomp!

puts 'Choose player B:'
player2 = gets.chomp!
mark = ''

def show_board(board)
	" #{board[0]} #{board[1]} #{board[2]}\n #{board[3]} #{board[4]} #{board[5]}\n #{board[6]} #{board[7]} #{board[8]}\n"
end

def validation(option, board)
	result = false
	result = true if option.between?(1,9) && !board[option - 1].is_a?(String)
	result
end

def won?(board, mark)
	cases = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8],[2, 4, 6]]
	8.times do |i|
		first  = board[cases[i][0]]
		second = board[cases[i][1]]
		third  = board[cases[i][2]]
		return true if [ first, second, third ].all?{ |elem| elem.to_s == mark }
	end
	false
end


def game_over?(board, moves, mark)
	moves >= 10 || won?(board, mark)
end

print show_board(board)


until game_over?(board, moves, mark)
	p 'choose a number between 1 - 9'
	option = gets.chomp!.to_i
	while validation(option, board) == false
		puts "Incorrect input, try again"
		option = gets.chomp!.to_i
	end

	if moves.odd?
		mark = 'x'
	else
		mark = 'o'
	end

	board[option-1] = mark
	print show_board(board)
	moves += 1
end

if 
print "#{mark} wins!"