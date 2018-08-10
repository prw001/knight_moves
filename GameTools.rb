require './game_board.rb'

module GameTools
	def build_move_tree(board, current_set)
		#returns a move tree (DAG)
		next_set = []
		current_set.each do |square|
			valid_moves = get_valid_moves(board, square.coordinates)
			if valid_moves.length > 0
				valid_moves.each do |next_square|
					unless next_square.has_inbound?
						next_set << next_square
					end
					square.paths << KnightPath.new(board, square.coordinates, next_square)
					next_square.paths << KnightPath.new(board, square.coordinates, next_square)
				end
			end
		end
		if next_set.length > 0
			build_move_tree(board, next_set)
		end
	end

	def check_outbound_path(square, stop)
		square.paths.each do |path|
			if path.to_square == stop
			   	return square
			end
		end
		return nil
	end

	def shortest_path(stop, squares, moveset = [])
		#returns shortest path based on provided arguments
		next_squares = []
		squares.each do |square|
			if (check_outbound_path(square, stop))
				moveset << stop
				moveset << square
				return moveset
			else
				square.paths.each do |path|
					#next set should only be unchecked squares
					if !(squares.include? path.to_square) &&
					   !(next_squares.include? path.to_square)
						next_squares << path.to_square
					end
				end
			end
		end
		if next_squares.length > 0
			#recursively call until destination is found
			moveset = shortest_path(stop, next_squares, moveset)
		end
		squares.each do |square|
			#trace the path ('moveset') by seeing which of the current
			#squares connects to the most recently added square.
			if(check_outbound_path(square, moveset[-1]))
				moveset << square
				break
			end
		end
		return moveset
	end

	def get_valid_moves(game, start)
		#determine if a square exists for each knight movement
		valid_moves = []
		coord_shifts = [[2, -1], [2, 1],
				[1, 2], [-1, 2],
				[-2, 1], [-2, -1],
				[1, -2], [-1, -2]]
		coord_shifts.each do |shift|
			new_coord = combine_coord(start, shift)
			if game.squares[new_coord]
				valid_moves << game.squares[new_coord]
			end
		end
		#return a set of square objects
		return valid_moves
	end

	def combine_coord(set_one, set_two)
		return [(set_one[0] + set_two[0]), (set_one[1] + set_two[1])]
	end
end