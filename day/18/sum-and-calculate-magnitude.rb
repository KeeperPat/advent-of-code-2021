#!/usr/bin/env ruby
require './lib/snailfish_number'

# See https://adventofcode.com/2021/day/18
INPUT_FILE = ARGV[0]

list = File.readlines(INPUT_FILE).map(&:strip)

puts SnailfishNumber.sum(list).magnitude