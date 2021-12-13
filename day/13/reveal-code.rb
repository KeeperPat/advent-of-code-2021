#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/13
def vertical_fold(points, fold_at_y)
    points.reject{|x, y| y == fold_at_y}.map do |x, y|
        if y < fold_at_y
            [x,y]
        else
            distance_from_fold = y - fold_at_y
            new_y = fold_at_y - distance_from_fold
            [x, new_y]
        end
    end.uniq
end

def horizontal_fold(points, fold_at_x)
    points.reject{|x, y| x == fold_at_x}.map do |x, y|
        if x < fold_at_x
            [x,y]
        else
            distance_from_fold = x - fold_at_x
            new_x = fold_at_x - distance_from_fold
            [new_x, y]
        end
    end.uniq
end

INPUT_FILE = ARGV[0]

points_input, commands_input = File.read(INPUT_FILE).split("\n\n")

points = points_input.split("\n").map{|point| point.split(',').map(&:to_i)}
commands = commands_input.split("\n").map{|command| command.delete("fold along ").split('=')}.map{|axis, position| [axis, position.to_i]}

commands.each do |axis, position|
    if axis == 'x'
        points = horizontal_fold(points, position)
    else
        points = vertical_fold(points, position)
    end
end

# Display Points
## Initialize 2D Array
max_x = points.map{|x, y| x}.max
max_y = points.map{|x, y| y}.max
display = (0..max_y).to_a.map{' ' * max_x}

## Populate Array
points.each do |x, y|
    display[y][x] = '*'
end

## Display
puts display.join("\n")
