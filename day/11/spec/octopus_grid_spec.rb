require 'octopus_grid'

describe OctopusGrid do

    before do
        @input = <<~OCTOPUS_GRID
            11111
            19991
            19191
            19991
            11111
        OCTOPUS_GRID

        @octopus_grid = OctopusGrid.new(@input)
    end

    describe "step!" do
        before do
            @octopus_grid.step!
        end

        it "increments the current_step" do
            expect(@octopus_grid.current_step).to eq(1)
        end

        it "updates octopus engergy levels" do
            expect(@octopus_grid.to_s).to eq(
                <<~OCTOPUS_GRID
                    34543
                    40004
                    50005
                    40004
                    34543
                OCTOPUS_GRID
            )
        end

        it "records the number of flashes" do
            expect(@octopus_grid.total_flashes).to eq(9)
        end
    end

    describe "current_step" do
        it "returns the current step" do
            expect(@octopus_grid.current_step).to eq(0)
        end
    end

    describe "total_flashes" do
        it "returns the total number of flashes" do
            expect(@octopus_grid.total_flashes).to eq(0)
        end
    end

    describe "to_s" do
        it "displays the current state of the grid" do
            expect(@octopus_grid.to_s).to eq(@input)
        end

    end
end