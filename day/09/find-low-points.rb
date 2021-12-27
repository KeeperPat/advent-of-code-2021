#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/9
INPUT_FILE = ARGV[0]

seafloor_map = File.readlines(INPUT_FILE).map{|line| line.strip.split('').map(&:to_i)}

def adjacent_values(x, y, seafloor_map)
    max_x = seafloor_map.first.size
    max_y = seafloor_map.size

    adjacent_values = []

    adjacent_values << seafloor_map[y][x-1] unless x - 1 < 0 # left
    adjacent_values << seafloor_map[y][x+1] unless x + 1 >= max_x # right
    adjacent_values << seafloor_map[y-1][x] unless y - 1 < 0 # above
    adjacent_values << seafloor_map[y+1][x] unless y + 1 >= max_y # below

    adjacent_values
end

low_points = seafloor_map.map.with_index do |row, row_index|
    row.select.with_index do |height, column_index|
        adjacent_values(column_index, row_index, seafloor_map).all?{|adjacent_value| adjacent_value > height}
    end
end.flatten

score = low_points.map{|low_point| low_point + 1}.sum
puts score