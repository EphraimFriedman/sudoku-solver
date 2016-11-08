class PuzzlesController < ApplicationController

	def index
		@puzzle = Puzzle.first.board.split('')

	end

	def solve
		@puzzle = Puzzle.find(params[:puzzle_id])
		@solved_board = @puzzle.solve_puzzle

		render json: @solved_board
	end
end
