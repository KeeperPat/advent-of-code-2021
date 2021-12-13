#!/usr/bin/env ruby
require './lib/graph'

# See https://adventofcode.com/2021/day/12
INPUT_FILE = ARGV[0]
STEPS = ARGV[1].to_i

graph = Graph.new(File.read(INPUT_FILE))

puts graph.paths('start', 'end').size
