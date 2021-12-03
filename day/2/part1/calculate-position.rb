#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/1
input = File.readlines(ARGV[0]).map(&:split)

horizontal_position = 0
depth = 0

input.each do |direction, distance|
    case direction
    when 'forward'
        horizontal_position += distance.to_i
    when 'up'
        depth -= distance.to_i
        depth = 0 if depth < 0
    when 'down'
        depth += distance.to_i
    end       
end

puts "Horizontal Position: #{horizontal_position}"
puts "Depth: #{depth}"
puts horizontal_position * depth