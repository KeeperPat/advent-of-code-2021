#!/usr/bin/env ruby

input = File.readlines(ARGV[0]).map(&:strip)
commands = input.map do |line|
    on = line.split(' ').first == 'on'
    dims = line.split(' ').last.split(',')
    x_dims = Range.new(*dims[0].split('=').last.split('..').map(&:to_i).sort)
    y_dims = Range.new(*dims[1].split('=').last.split('..').map(&:to_i).sort)
    z_dims = Range.new(*dims[2].split('=').last.split('..').map(&:to_i).sort)

    [on, x_dims, y_dims, z_dims]
end

matrix = {}

INITIALIZATION_REGION = (-50..50).to_a

commands.each do |on, x_dim, y_dim, z_dim|
    if x_dim.to_a.intersect?(INITIALIZATION_REGION) && y_dim.to_a.intersect?(INITIALIZATION_REGION) && z_dim.to_a.intersect?(INITIALIZATION_REGION)
        x_dim.to_a.product(y_dim.to_a, z_dim.to_a).each do |coords|
            matrix[coords] = on
        end
    end
end

number_of_cubes_turned_on = matrix.values.count{|location| location == true}

puts number_of_cubes_turned_on
