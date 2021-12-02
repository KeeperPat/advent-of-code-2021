#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/1
previous_depth = nil
number_of_times_depth_increases = 0

File.readlines(ARGV[0]).each do |depth|
    current_depth = depth.to_i

    number_of_times_depth_increases += 1 if previous_depth && current_depth > previous_depth

    previous_depth = current_depth
end

puts number_of_times_depth_increases