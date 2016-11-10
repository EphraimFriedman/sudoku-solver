class Puzzle < ApplicationRecord


def solve_puzzle

  # new_board = str_to_array
	@board = self.board

	str_to_array
  change_epmty_cell_to_posibilities

  until solved?

    @board.map do |row|
      row.map!.with_index do |cell, index|

        if cell.length > 1

					cell = cell - get_row_column_box(@board.index(row), index)

            if cell.length == 1
              cell = cell[0]
            else
              cell
            end
        else
          cell
        end
      end
    end
  end

  @board.flatten.join
end


def solved?
  @board.each do |row|
    return false unless row.flatten.sort == ("1".."9").to_a
  end
end


	def str_to_array
	  @board = @board.split("").each_slice(9).to_a
	end

	def change_epmty_cell_to_posibilities
	  @board = @board.map do |row|
	    row.map! do |cell|
	      if cell == "-"
	        cell = ("1".."9").to_a
	      else
	        cell
	      end
	    end
	  end
	end

	def get_row_column_box(row_index, cell_index)
		get_row(row_index) + get_column(cell_index) + get_box(row_index, cell_index)

	end

	def get_row(index)
		@board[index].reject {|num| num.is_a?(Array)}
	end

	def get_column(cell_index)
	  @board.map do |row|
	    row[cell_index] unless row[cell_index].is_a?(Array)
	  end
	 # Another way I played around with
	 # @board.transpose[cell_index].reject {|num| num.is_a?(Array)}
	end

	def get_box(cell_row, cell_index)
	  #Get the first cell in the box, x and y coordinates
	  x = cell_row / 3 * 3
	  y = cell_index / 3 * 3
	  box = []

	  # Get the 3 filled cells from every row in the box
	  3.times do
	    box << @board[x][y.. (y + 2)].reject {|num| num.is_a?(Array)}
	    x += 1
	  end

	  box.flatten
	end

end

## advanced logic for puzzles 5- 10
	# # IF the cell length is greater than 1
	# # find all possibilities within row
	# # IF there is only one unique number
	# # then set the cell to that number
	# # otherwise continue loop
	# # check the same against the colum and box posibilities
