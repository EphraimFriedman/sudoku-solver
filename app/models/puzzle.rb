class Puzzle < ApplicationRecord

	def solve_puzzle
		new_board = initialize_board
		logically_solved = logical_solve(new_board)
		guess_solved = guess_solve(logically_solved)
		
		guess_solved.join
	end

	def initialize_board
		self.board.chars.map(&:to_i)
	end 

	def row_index(cell_index)
		cell_index / 9
	end

	def column_index(cell_index)
		cell_index % 9
	end

	def box_index(cell_index) # gets which box it is in 0 through 8
		x = row_index(cell_index) / 3 
		y = column_index(cell_index) / 3
		(x * 3) + y
	end

	def row(board, cell_index)
		start_index = row_index(cell_index) * 9
		end_index = start_index + 9

		board[start_index...end_index]
	end

	def column(board, cell_index)
		column_index = column_index(cell_index)
		board.select.with_index{|v, i| column_index(i) == column_index}
	end

	def box(board, cell_index)
		box_index = box_index(cell_index)
		board.select.with_index{|v, i| box_index(i) == box_index}
	end

	def rows(board)
		(0..8).map{|i| row(board, i * 9)}
	end

	def columns(board)
		(0..8).map{|i| column(board, i)}
	end

	def boxes(board)
	 [box(board, 0), box(board, 3), box(board, 6),
		box(board, 27) ,box(board, 30) ,box(board, 33),
		box(board, 56) ,box(board, 59) ,box(board, 62)]
	end

	def valid_group?(group)
		group.uniq.length == group.length &&
		group.all?{|i| i != 0}
	end

	def valid?(board)
		rows(board).all?{|row| valid_group?(row)} &&
		columns(board).all?{|column| valid_group?(column)} &&
		boxes(board).all?{|box| valid_group?(box)} 
	end

	def empty_positions(board)
		(0..80).to_a.select{|i| board[i] == 0}
	end

	def possibilities(board, cell_index)
		existing_nums = row(board, cell_index) + column(board, cell_index) + box(board, cell_index)
		(1..9).to_a - existing_nums
	end

	def logical_solve(board)
		old_board = board

		loop do
			new_board = old_board.dup
			empty_positions(new_board).each do |cell_index|
				cell_options = possibilities(new_board, cell_index)
				if cell_options.length == 1
					new_board[cell_index] = cell_options.first
				end
			end

			if new_board == old_board
				return new_board
			else
				old_board = new_board
			end
		end
	end

	def guess_solve(board) 
		return board if empty_positions(board).empty?  

		first_position = empty_positions(board).first

		possibilities(board, first_position).each do |guess|

			new_board = board.dup
			new_board[first_position] = guess
			solved_board = guess_solve(new_board)

			if valid?(solved_board)
				return solved_board
			end
		end
		board
	end
end