require 'grid'

describe Grid do
	context "(on initialization)" do
		let(:puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600' }
		let(:grid)   { Grid.new(puzzle) }
		
		it "should have 81 cells" do
			expect(grid.cells.length).to eq(81)
		end

		it "should have an unsolved first cell" do
			expect(grid.cells[0].solved?).to be_false
		end

		it "should have a solved second cell with value 1" do
			expect(grid.cells[1].solved?).to be_true
		end
	end

	it "should know if it's not solved" do
		puzzle = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
		grid = Grid.new(puzzle)
		expect(grid.solved?).to be_false
	end

	it "should know if it is solved" do
		solved_puzzle = '123456789123456789123456789123456789123456789123456789123456789123456789123456789'
		solved_grid = Grid.new(solved_puzzle)
		expect(solved_grid.solved?).to be_true
	end

	context "(dealing with neighbours)" do
		let(:puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600' }
		let(:grid)   { Grid.new(puzzle) }

		it "should know what row a cell is in" do
			expect(grid.row_of(grid.cells[0])).to eq([0,1,5,0,0,3,0,0,2])
		end

		it "should know what column a cell is in" do
			expect(grid.column_of(grid.cells[0])).to eq([0,0,2,4,5,0,9,8,0])
		end

		it "should know what square a cell is in" do
			expect(grid.square_of(grid.cells[0])).to eq([0,1,5,0,0,0,2,7,0])
		end

		it "should know all the values of the neighbours of a cell" do
			expect(grid.neighbours_of(grid.cells[0])).to eq([1,2,3,4,5,7,8,9])
		end

		it "should set the neihgbours of a cell on initialization" do
			expect(grid.cells[0].neighbours).to eq([1,2,3,4,5,7,8,9])
		end
	end
end