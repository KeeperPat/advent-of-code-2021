require 'graph'

describe Graph do
    before do
        @input = <<~EDGES
            start-A
            start-b
            A-c
            A-b
            b-d
            A-end
            b-end
        EDGES

        @graph = Graph.new(@input)
    end

    describe "to_s" do
        it "displays the current state of the grid" do
            expect(@graph.to_s).to eq(@input)
        end
    end
end