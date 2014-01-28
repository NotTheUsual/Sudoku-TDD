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
	end
end