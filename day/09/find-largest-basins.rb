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

low_point_coordinates = seafloor_map.map.with_index do |row, row_index|
    row.map.with_index do |height, column_index|
        if adjacent_values(column_index, row_index, seafloor_map).all?{|adjacent_value| adjacent_value > height}
            [column_index, row_index]
        else
            nil
        end
    end
end.flatten(1).reject(&:nil?)

def all_adjacent_coordinates(x, y, seafloor_map, visited)
    next_coords = [
        [0,1],
        [1,0],
        [0,-1],
        [-1,0]
    ].map do |x_offset, y_offset|
        coordinates = [x + x_offset, y + y_offset]
    end.select do |x_coord, y_coord|
        max_x = seafloor_map.first.size
        max_y = seafloor_map.size

        x_coord >= 0 && x_coord < max_x &&
        y_coord >= 0 && y_coord < max_y &&
        !visited.include?([x_coord, y_coord]) &&
        seafloor_map[y_coord][x_coord] != 9
    end

    next_coords.map do |x_coord, y_coord|
        visited << [x_coord, y_coord]
        all_adjacent_coordinates(x_coord, y_coord, seafloor_map, visited)
    end

    visited.uniq
end

def basin_size(starting_x, starting_y, seafloor_map)
    points_in_basin = all_adjacent_coordinates(starting_x, starting_y, seafloor_map, [])

    points_in_basin.size
end

puts low_point_coordinates.map{|x, y| basin_size(x, y, seafloor_map)}.sort.reverse.first(3).inject(:*)