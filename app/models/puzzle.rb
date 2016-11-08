class Puzzle < ApplicationRecord

	def solve

	end

def solve_puzzle

  new_board = str_to_array
  
  running_board = epmty_cell_to_posibilities(new_board)

  until solved?(running_board)

    running_board.map! do |row|
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
  # binding.pry
  board.each do |row|
    if row.flatten.sort == ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
      true
    else
      return false
    end
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
  split_str = self.board.split("")
  board_array = []
  9.times { board_array << split_str.shift(9) }
  board_array
end

def epmty_cell_to_posibilities(board)
  board.map! do |row|
    row.map! do |cell|
      if cell == "-"
        cell = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
      else
        cell
      end
    end
  end
  board
end



def get_column(grid, cell_index)
  column_array =[]
  grid.each do |row|
    if row[cell_index].length == 1
    column_array << row[cell_index]
  end
  end
  column_array
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

box =[]

  if cell_row <= 2
    if cell_index <= 2
      counter = 0
      until counter == 3
        box << grid[counter][0..2]
        counter+=1
      end
    elsif cell_index >= 3 && cell_index <= 5
       counter = 0
      until counter == 3
        box << grid[counter][3..5]
        counter+=1
      end
    elsif cell_index >= 6 && cell_index <= 8
      counter = 0
      until counter == 3
        box << grid[counter][6..8]
        counter+=1
      end
    end

  elsif cell_row >=3 && cell_row <=5
    if cell_index <= 2

      counter = 0
      until counter == 3
        box << grid[counter + 3][0..2]
        counter+=1
      end
    elsif cell_index >= 3 && cell_index <= 5
       counter = 0
      until counter == 3
        box << grid[counter + 3][3..5]
        counter+=1
      end
    elsif cell_index >= 6 && cell_index <= 8
      counter = 0
      until counter == 3
        box << grid[counter + 3][6..8]
        counter+=1
      end
    end

  elsif cell_row >=6
    if cell_index <= 2

      counter = 0
      until counter == 3
        box << grid[counter + 6][0..2]
        counter+=1
      end
    elsif cell_index >= 3 && cell_index <= 5
       counter = 0
      until counter == 3
        box << grid[counter + 6][3..5]
        counter+=1
      end
    elsif cell_index >= 6 && cell_index <= 8
      counter = 0
      until counter == 3
        box << grid[counter + 6][6..8]
        counter+=1
      end
    end
  end
  # find numbers from box to compare later
  new_box = []
  box.flatten!(1)
  box.each do |row|
      if !row.is_a?(Array)
        new_box << row
      end
  end
  new_box
end

end
