#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/6
INPUT_FILE = ARGV[0]

starting_positions = File.readlines(INPUT_FILE).first.split(',').map(&:to_i)

max_position = starting_positions.max

total_fuel = (1..max_position).to_a.map{|position|
    starting_positions.sum{|starting_position| (starting_position - position).abs}
}.min

puts total_fuel