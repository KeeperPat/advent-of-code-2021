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

    describe "paths" do
        it "returns all paths that visit each lowercase cave at most once" do
            all_paths = [
                'start,A,b,A,c,A,end',
                'start,A,b,A,end',
                'start,A,b,end',
                'start,A,c,A,b,A,end',
                'start,A,c,A,b,end',
                'start,A,c,A,end',
                'start,A,end',
                'start,b,A,c,A,end',
                'start,b,A,end',
                'start,b,end',
            ]

            expect(@graph.paths('start', 'end')).to eq(Set.new(all_paths))
        end

        it "finds path from one node to another" do
            @input = <<~EDGES
                start-A
                A-end
            EDGES
             @graph = Graph.new(@input)

             expect(@graph.paths('start', 'end')).to eq(Set.new(['start,A,end']))
        end
    end

    describe "to_s" do
        it "displays the current state of the grid" do
            expect(@graph.to_s).to eq(@input)
        end
    end
end