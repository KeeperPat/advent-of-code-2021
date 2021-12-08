#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/6
INPUT_FILE = ARGV[0]

entries = File.readlines(INPUT_FILE).map{|line| line.strip.split(' | ').map(&:split)}

count = entries.map{|signal_patterns, output_values| output_values.count{|value| [2,3,4,7].include?(value.length)}}.sum

puts "Count of 1s, 4s, 7s, and 8s: #{count}"