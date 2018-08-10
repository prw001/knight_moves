require './game_board.rb'
require './GameTools.rb'
def select_squares
	#random start and end points that do not match
	squares = [[rand(0..7), rand(0..7)], [rand(0..7), rand(0..7)]]
	unless squares[0] == squares[1]
		return squares
	else
		return select_squares
	end
end

def knight_moves
	include GameTools

	start_and_stop = select_squares
	start_coord = start_and_stop[0]
	stop_coord = start_and_stop[1]

	board = GameBoard.new
	start_square = board.squares[start_coord]
	stop_square = board.squares[stop_coord]

	build_move_tree(board, [start_square])
	moves = shortest_path(stop_square, [start_square]).reverse

	board.draw_board_with_path(moves)
	puts "Start position: " + start_coord.to_s
	puts "Stop position: " + stop_coord.to_s

	move_coords = ''
	moves.each do |square|
		move_coords += square.coordinates.to_s + " "
	end
	return move_coords
end

moves = knight_moves

puts "\nKnight Moves:", moves