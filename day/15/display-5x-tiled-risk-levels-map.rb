#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/15
INPUT_FILE = ARGV[0]

input = File.read(INPUT_FILE)

risk_levels_tile = input.split("\n").map{|row| row.split('').map(&:to_i)}

max_x = risk_levels_tile.first.size
max_y = risk_levels_tile.size

full_risk_levels = (5 * max_y).times.map{|_| Array.new(5*max_x, 0)}

risk_levels_tile.each_with_index do |row, y|
    row.each_with_index do |risk_level, x|
        5.times do |x_tile|
            x_pos = (x_tile * max_x) + x
            5.times do |y_tile|
                y_pos = (y_tile * max_x) + y
                new_risk_level = risk_level + x_tile + y_tile
                if new_risk_level > 9
                    new_risk_level = new_risk_level - 9
                end
                full_risk_levels[y_pos][x_pos] = new_risk_level
            end
        end
    end
end

puts full_risk_levels.map{|row| row.join}.join("\n") + "\n"