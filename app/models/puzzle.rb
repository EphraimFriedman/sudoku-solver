class Puzzle < ApplicationRecord

	
def solve_puzzle

  # new_board = str_to_array
  
  running_board = epmty_cell_to_posibilities(str_to_array)

  until solved?(running_board)

    running_board.map do |row|
      row.map!.with_index do |cell, index|
      	
        if cell.length > 1
          # check cell against row
          cell = checker(row, cell)

          # get column
          column = get_column(running_board, index)
          
          # check cell against column
          cell = checker(column, cell)
          # get box

          box = get_box(running_board, running_board.index(row), index)
          # check cell against box
          cell = checker(box, cell)

          ## advanced logic for puzzles 5- 10
            # # IF the cell length is greater than 1
            # # find all possibilities within row
            # # IF there is only one unique number
            # # then set the cell to that number
            # # otherwise continue loop
            # # check the same against the colum and box posibilities


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
  
  running_board.flatten
end

# Returns a boolean indicating whether
# or not the provided board is solved.
# The input board will be in whatever
# form `solve` returns.
def solved?(board)
  board.each do |row|
    return false unless row.flatten.sort == ("1".."9").to_a
  end
end

# Takes in a board in some form and
# returns a _String_ that's well formatted
# for output to the screen. No `puts` here!
# The input board will be in whatever
# form `solve` returns.
# def pretty_board(board)
#   puts "-" * 18
#   board.each {|row| puts row.join(" ")}
#   puts "-" * 18
# end


def str_to_array
  self.board.split("").each_slice(9).to_a
end

def epmty_cell_to_posibilities(board)
  board.map do |row|
    row.map! do |cell|
      if cell == "-"
        cell = ("1".."9").to_a 
      else
        cell
      end
    end
  end  
end



def get_column(grid, cell_index)
  grid.map do |row|
    row[cell_index] unless row[cell_index].is_a?(Array) 
  end  
 # Another way I played around with
 # grid.transpose[cell_index].reject {|num| num.is_a?(Array)}
end


def checker(single_array, cell_posibilities)
  new_posibilities = []
  cell_posibilities.map do |num|
    if single_array.include?(num) == false
      new_posibilities << num
    end
  end
  cell_posibilities = new_posibilities
end

def get_box(grid, cell_row, cell_index)
  #Get the first cell in the box, x and y coordinates 
  x = cell_row / 3 * 3
  y = cell_index / 3 * 3
  box = []
  
  # Get the 3 filled cells from every row in the box
  3.times do 
    box << grid[x][y.. (y + 2)].reject {|num| num.is_a?(Array)}
    x += 1
  end

  box.flatten
end


end
