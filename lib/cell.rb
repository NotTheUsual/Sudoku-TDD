class Cell
	attr_reader :value

	def initialize(value)
		@value = value
	end

	def solved?
		@value != 0
	end
end