class PuzzlesController < ApplicationController

	def index
			@puzzle = Puzzle.first(5).sample
			# @puzzle = Puzzle.find(6)
		if request.xhr?
			render json: @puzzle
		else
			@puzzle
		end
	end

	def solve
		@puzzle = Puzzle.find(params[:puzzle_id])
		@solved_board = @puzzle.solve_puzzle

		render text: @solved_board
	end
end
