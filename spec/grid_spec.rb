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

	context "(trying to solve the damned thing)" do
		it "should be able to solve a really easy sudoku" do
			really_easy_puzzle = '615493872348127956279568431496832517521746389783915264952681743864379125137254690'
			really_easy_grid = Grid.new(really_easy_puzzle)
			really_easy_grid.solve
			expect(really_easy_grid).to be_solved
		end

		it "should be able to solve an easy sudoku" do
			puzzle = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
			grid = Grid.new(puzzle)
			expect(grid).not_to be_solved
			grid.solve
			expect(grid).to be_solved
		end
	end

	context "(with really hard sudoku)" do
		it "should be able to solve a sudoku with one guess" do
			one_guess_puzzle = '034567890568129347790348056315274689426893715879651423640935078983712564057486930'
			grid = Grid.new(one_guess_puzzle)
			expect(grid).not_to be_solved
			grid.solve
			expect(grid).to be_solved
		end
	end

	context "(printing)" do
		let(:puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600' }
		let(:grid)   { Grid.new(puzzle) }

		it "should be able to print itself out without objects" do
			expect(grid.inspect).not_to include("Cell")
		end

		it "should be able to print an incomplete sudoku" do
			expect(grid.inspect).to eq([0, 1, 5, 0, 0, 3, 0, 0, 2, 0, 0, 0, 1, 0, 0, 9, 0, 6, 2, 7, 0, 0, 6, 8, 4, 3, 0, 4, 9, 0, 0, 0, 2, 0, 1, 7, 5, 0, 1, 0, 4, 0, 3, 8, 0, 0, 0, 3, 9, 0, 5, 0, 0, 0, 9, 0, 0, 0, 8, 1, 0, 4, 0, 8, 6, 0, 0, 7, 0, 0, 2, 5, 0, 3, 7, 2, 0, 4, 6, 0, 0])
		end

		it "should be able to print a complete sudoku" do
			grid.solve
			expect(grid.inspect).to eq([6, 1, 5, 4, 9, 3, 8, 7, 2, 3, 4, 8, 1, 2, 7, 9, 5, 6, 2, 7, 9, 5, 6, 8, 4, 3, 1, 4, 9, 6, 8, 3, 2, 5, 1, 7, 5, 2, 1, 7, 4, 6, 3, 8, 9, 7, 8, 3, 9, 1, 5, 2, 6, 4, 9, 5, 2, 6, 8, 1, 7, 4, 3, 8, 6, 4, 3, 7, 9, 1, 2, 5, 1, 3, 7, 2, 5, 4, 6, 9, 8])
		end

		it "should be able to print itself out as a string" do
			grid.solve
			expect(grid.to_s).to eq('615493872348127956279568431496832517521746389783915264952681743864379125137254698')
		end
	end
end