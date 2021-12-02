#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/2

# First calculate sums for slding windows.
input = File.readlines(ARGV[0]).map(&:to_i)

sliding_window_sums = input.each_cons(3).map(&:sum)

# Then calculate number of times depth increases
previous_sum = nil
number_of_times_depth_increases = 0

sliding_window_sums.each do |sum|
    number_of_times_depth_increases += 1 if previous_sum && sum > previous_sum

    previous_sum = sum
end

puts number_of_times_depth_increases