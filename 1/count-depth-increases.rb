#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/1
input = File.readlines(ARGV[0]).map(&:to_i)

number_of_times_depth_increases = input.each_cons(2).map{ |previous_depth, current_depth|
    current_depth > previous_depth ? 1 : 0
}.sum

puts number_of_times_depth_increases