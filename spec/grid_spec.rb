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

	let(:puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600' }
	let(:grid)   { Grid.new(puzzle) }

	it "should know if it's not solved" do
		expect(grid.solved?).to be_false
	end

	let(:solved_puzzle) { '123456789123456789123456789123456789123456789123456789123456789123456789123456789' }
	let(:solved_grid)   { Grid.new(solved_puzzle) }

	it "should know if it is solved" do
		expect(solved_grid.solved?).to be_true
	end
end