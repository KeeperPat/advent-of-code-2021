#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/5
input = File.readlines(ARGV[0]).map(&:strip)

line_segment_endpoints = input.map{|line_segment| line_segment.split(' -> ').map{|point| point.split(',').map(&:to_i)}}
max_x = line_segment_endpoints.map{|point| point.first}.flatten.max
max_y = line_segment_endpoints.map{|point| point.last}.flatten.max

seafloor_map = Array.new(max_x + 1){Array.new(max_y + 1, 0)}

def horizontal?(endpoints)
    point1, point2 = endpoints.sort
    x1, y1 = point1
    x2, y2 = point2
    
    y1 == y2
end

def vertical?(endpoints)
    point1, point2 = endpoints.sort
    x1, y1 = point1
    x2, y2 = point2
    
    x1 == x2
end

def line_segment_from_endpoints(endpoints)
    point1, point2 = endpoints.sort
    x1, y1 = point1
    x2, y2 = point2

    if vertical?(endpoints)
        (y1..y2).to_a.map{|y| [x1, y]}
    elsif horizontal?(endpoints)
        (x1..x2).to_a.map{|x| [x, y1]}
    else
        x_coords = x1 < x2 ? x1.upto(x2).to_a : x1.downto(x2).to_a
        y_coords = y1 < y2 ? y1.upto(y2).to_a : y1.downto(y2).to_a
        x_coords.zip(y_coords)
    end
end

all_points = line_segment_endpoints.map{|endpoints| line_segment_from_endpoints(endpoints)}.flatten(1)

all_points.each do |x, y|
    seafloor_map[x][y] += 1
end

number_of_points_with_overlapping_lines = seafloor_map.flatten.select{|count| count > 1}.size

puts "Points with overlapping lines: #{number_of_points_with_overlapping_lines}"