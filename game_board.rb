class KnightPath
	#instance of game object is passed in to access its squares
	attr_accessor :from_square, :to_square
	def initialize(game, from_square, to_square)
		@from_square = game.squares[from_square]
		@to_square = to_square
	end
end

class ChessSquare
	attr_accessor :paths
	attr_reader :coordinates
	def initialize(coordinates)
		@coordinates = coordinates
		@paths = []
	end

	def has_inbound?
		@paths.each do |path|
			if path.to_square == self
				return true
			end
		end
		return false
	end
end

class GameBoard
	attr_reader :squares
	def initialize
		@columns = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
		@rows = [1, 2, 3, 4, 5, 6, 7, 8]
		@squares = {}
		@columns.each_with_index do |column, column_index|
			@rows.each_with_index do |row, row_index|
				@squares[[column_index, row_index]] = ChessSquare.new([column_index, row_index])
			end
		end
	end

	def draw_board_with_path(moveset)
		row = "\n   0  1  2  3  4  5  6  7\n +-----------------------\n0| "
		@squares.keys.each_with_index{|key, index|
			if (moveset.include? @squares[key])
				move_num = moveset.find_index(@squares[key]) + 1
				row += move_num.to_s + '.'
			end
			if (index + 1) % 8 == 0 && (index + 1) != 64
				unless row[row.length - 1] == "."
					row += "o\n\n#{(index + 1)/8}| "
				else
					row += "\n\n#{(index + 1)/8}  "
				end
			else
				unless row[row.length - 1] == "."
					row += "o  "
				else
					row += " "
				end
			end
		}
		puts row, "\n"
	end
end