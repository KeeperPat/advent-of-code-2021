#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/6
INPUT_FILE = ARGV[0]

starting_positions = File.readlines(INPUT_FILE).first.split(',').map(&:to_i)

max_position = starting_positions.max

least_costly_position = (1..max_position).to_a.min_by do |position|
    starting_positions.sum{|starting_position| (starting_position - position).abs}
end

total_fuel = starting_positions.sum{|starting_position| (starting_position - least_costly_position).abs}

puts total_fuel