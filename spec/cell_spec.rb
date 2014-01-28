require 'cell'

describe Cell do
	context "(on initialization)" do
		let(:value) { 4 }
		let(:cell)  { Cell.new(value) }
		
		it "should have a value of 4" do
			expect(cell.value).to eq(4)
		end
	end

	let(:cell) { Cell.new(4) }

	it "should know if it's solved" do
		expect(cell.solved?).to be_true
	end

	let(:empty_cell) { Cell.new(0) }

	it "should know if it's not solved" do
		expect(empty_cell.solved?).not_to be_true
	end
end