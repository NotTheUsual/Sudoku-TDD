class Grid
	attr_reader :cells

	ROWS =    (0...9).map { |i| Array.new(9) { |i| i }.map { |v| v + (i*9) } }
	COLUMNS = (0...9).map { |i| Array.new(9) { |i| i * 9 }.map { |v| v + i } }
	SQUARES = [[0,1,2,9,10,11,18,19,20],[3,4,5,12,13,14,21,22,23],[6,7,8,15,16,17,24,25,26],[27,28,29,36,37,38,45,46,47],[30,31,32,39,40,41,48,49,50],[33,34,35,42,43,44,51,52,53],[54,55,56,63,64,65,72,73,74],[57,58,59,66,67,68,75,76,77],[60,61,62,69,70,71,78,79,80]]

	def initialize(puzzle)
		@cells = puzzle.chars.map { |value| Cell.new(value.to_i) }
		@cells.each { |cell| cell.neighbours = neighbours_of(cell) }
	end

	def solved?
		@cells.all? { |cell| cell.solved? }
	end

	def index_of cell
		@cells.index(cell)
	end

	def row_of cell
		row = ROWS.select { |row| row.include?(index_of(cell)) }.flatten
		row.map { |i| @cells[i].value }
	end

	def column_of cell
		column = COLUMNS.select { |column| column.include?(index_of(cell)) }.flatten
		column.map { |i| @cells[i].value }
	end

	def square_of cell
		square = SQUARES.select { |square| square.include?(index_of(cell)) }.flatten
		square.map { |i| @cells[i].value }
	end

	def neighbours_of cell
		values = row_of(cell) + column_of(cell) + square_of(cell) - [0]
		values.uniq!.sort!
	end

	def solve
		outstanding_before, endless_looping = 81, false
		while !solved? && !endless_looping
			@cells.each do |c|
				c.neighbours = neighbours_of(c)
				c.solve
			end
			outstanding = @cells.count { |c| c.solved? }
			endless_looping = outstanding_before == outstanding
			outstanding_before = outstanding
		end
	end

	def inspect
		@cells.map do |cell|
			cell.value
		end
	end

	def to_s
		self.inspect.join
	end
end