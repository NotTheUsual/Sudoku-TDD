class Cell
	attr_reader   :value
	attr_accessor :neighbours

	def initialize(value)
		@value = value
		@neighbours = []
	end

	def solved?
		@value != 0
	end

	def candidates
		(1..9).to_a - neighbours
	end

	def solve
		return if solved?
		raise unless solvable?
		@value = candidates[0] if candidates.length == 1
	end

	def guess_value(value)
		@value = value
	end

	def valid?
		!@neighbours.include?(value)
	end

	def solvable?
		@neighbours != (1..9).to_a
	end
end