#!/usr/bin/env ruby
require './lib/arithmetic_logic_unit'

# See https://adventofcode.com/2021/day/24
INPUT_FILE = ARGV[0]

alu = ArithmeticLogicUnit.new(File.read(INPUT_FILE))

code = 99_999_999_999_999

while true
    input = code.digits.reverse

    next if input.include?(0)

    break if alu.process!(input)['z'] == 0

    code -= 1
end

puts code