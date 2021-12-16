#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/15
INPUT_FILE = ARGV[0]

input = File.read(INPUT_FILE)

risk_levels = input.split("\n").map{|row| row.split('').map(&:to_i)}

@max_x = risk_levels.first.size
@max_y = risk_levels.size

ADJACENT_OFFSETS = [
    [0,1],
    [1,0],
    [0,-1],
    [-1,0],
]

def adjacent_coordinates(x, y)
    ADJACENT_OFFSETS.map do |x_offset, y_offset|
        [x + x_offset, y + y_offset]
    end.select do |x, y|
        valid_coordinates?(x, y)
    end
end

def valid_coordinates?(x, y)
    (x >= 0 && x < @max_x) && (y >= 0 && y < @max_y)
end

require 'set'

edges_with_weights = Set.new

risk_levels.map.with_index do |row, y|
    row.map.with_index do |cell, x|
        adjacent_coordinates(x, y).each do |neighbor_x, neighbor_y|
            edges_with_weights << [[[x,y], [neighbor_x, neighbor_y]], risk_levels[y][x]]
        end
    end
end

edges_with_weights = edges_with_weights.to_a.to_h

require 'rgl/adjacency'
require 'rgl/dijkstra'

graph = RGL::AdjacencyGraph.new
graph.add_edges(*edges_with_weights.keys)

shortest_path = graph.dijkstra_shortest_path(lambda { |edge| edges_with_weights[edge] }, [0,0], [@max_x-1, @max_y-1])

shortest_path.shift # discard starting point

puts shortest_path.map{|x, y| risk_levels[y][x]}.sum