class PuzzlesController < ApplicationController

	def index
		@puzzle = Puzzle.first(14).sample

		if request.xhr?
			render json: @puzzle
		else
			@puzzle
		end
	end

	def solve
		@puzzle = Puzzle.find(params[:puzzle_id])
		@solved_board = @puzzle.solve_puzzle

		render plain: @solved_board
	end
end
