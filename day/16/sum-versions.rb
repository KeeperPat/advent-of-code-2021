#!/usr/bin/env ruby
require './lib/command_parser'

# See https://adventofcode.com/2021/day/16
INPUT_FILE = ARGV[0]

commands = CommandParser.parse(File.read(INPUT_FILE))

puts commands.map{|command| command[:version]}.sum
