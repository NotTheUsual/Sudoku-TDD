require 'cell'

describe Cell do
	context "(on initialization)" do
		let(:cell)  { Cell.new(4) }
		
		it "should have a value of 4" do
			expect(cell.value).to eq(4)
		end
	end

	let(:cell) { Cell.new(4) }
	let(:empty_cell) { Cell.new(0) }

	it "should know if it's solved" do
		expect(cell.solved?).to be_true
	end

	it "should know if it's not solved" do
		expect(empty_cell.solved?).not_to be_true
	end

	it "should be able to say what its neighbours are" do
		expect(empty_cell.neighbours).to eq([])
	end

	it "should be able to have its neighbours updated" do
		expect(empty_cell.neighbours).to eq([])
		empty_cell.neighbours = [1,2,3]
		expect(empty_cell.neighbours).to eq([1,2,3])
	end

	it "should be able to see what its candidate values are" do
		empty_cell.neighbours = [1,2,3,4,5]
		expect(empty_cell.candidates).to eq([6,7,8,9])
	end

	it "should know if it is invalid" do
		empty_cell.neighbours = [2,3,4,5,6,7,8,9]
		empty_cell.solve
		expect(empty_cell).to be_valid
		empty_cell.neighbours = [1,2,3,4,5,6,7,8,9]
		expect(empty_cell).not_to be_valid
	end

	it "should know if it is valid" do
		empty_cell.neighbours = [2,3,4,5,6,7,8,9]
		empty_cell.solve
		expect(empty_cell).to be_valid
	end

	it "should know if it is solvable" do
		empty_cell.neighbours = [2,3,4,5,6,7,8,9]
		expect(empty_cell).to be_solvable
	end

	it "should know it is unsolvable" do
		empty_cell.neighbours = [1,2,3,4,5,6,7,8,9]
		expect(empty_cell).not_to be_solvable
	end

	context "(when solving)" do
		let(:cell)  { Cell.new(4) }

		it "should do nothing if solved" do
			expect(cell.solve).to eq(nil)
			expect(cell.value).to eq(4)
		end

		it "should set the value if there's only one candidate value" do
			empty_cell.neighbours = [1,2,3,4,5,6,7,8]
			empty_cell.solve
			expect(empty_cell.value).to eq(9)
		end

		it "should do nothing if there's more than one candidate value" do
			empty_cell.neighbours = [1,2,3,4,5,6,7]
			expect(empty_cell.solve).to eq(nil)
			expect(empty_cell.value).to eq(0)
		end

		it "should raise an error if it isn't possible to solve it" do
			empty_cell.neighbours = [1,2,3,4,5,6,7,8,9]
			expect{empty_cell.solve}.to raise_error
		end
	end

	context "(when solving a hard sudoku)" do
		it "should be able to make a guess" do
			empty_cell = Cell.new(0)
			empty_cell.neighbours = [3,4,5,6,7,8,9]
			expect(empty_cell.value).to eq(0)
			empty_cell.guess_value(1)
			expect(empty_cell.value).to eq(1)
		end
	end
end