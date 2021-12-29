#!/usr/bin/env ruby
require './lib/snailfish_number'

# See https://adventofcode.com/2021/day/18
INPUT_FILE = ARGV[0]

list = File.readlines(INPUT_FILE).map(&:strip)

puts list.permutation(2).map{|first, second| (SnailfishNumber.new(first) + second).reduce.magnitude}.max