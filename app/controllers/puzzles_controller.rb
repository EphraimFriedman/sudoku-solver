class PuzzlesController < ApplicationController

	def index
		@puzzle = Puzzle.first.board.split('')

	end

	def solve

		render text: 'hello'
	end
end
