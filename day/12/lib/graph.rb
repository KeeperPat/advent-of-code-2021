require 'set'

class Graph
    def initialize(input)
        @edges = input.split("\n").map{|row| row.split('-')}
    end

    def to_s
        @edges.map{|nodes| nodes.join('-')}.join("\n") + "\n"
    end
end