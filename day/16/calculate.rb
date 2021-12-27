#!/usr/bin/env ruby
require './lib/command_parser'

# See https://adventofcode.com/2021/day/16
INPUT_FILE = ARGV[0]

hex_transmission = File.read(INPUT_FILE).strip

puts CommandParser.calculate(CommandParser.parse(hex_transmission))
