#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/2

# First calculate sums for slding windows.
input = File.readlines(ARGV[0]).map(&:to_i)

sliding_window_sums = input.each_cons(3).map(&:sum)

# Then calculate number of times depth increases
number_of_times_depth_increases = sliding_window_sums.each_cons(2).map{ |previous_depth, current_depth|
    current_depth > previous_depth ? 1 : 0
}.sum

puts number_of_times_depth_increases