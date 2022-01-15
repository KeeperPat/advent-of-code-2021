#!/usr/bin/env ruby
require 'hashie/mash'

class Cuboid
    attr_reader :on, :bottom_left, :top_right
    alias_method 'on?', :on

    def initialize(on, x_dims, y_dims, z_dims)
        @on = on
        @bottom_left = Hashie::Mash.new(
            x: x_dims.first,
            y: y_dims.first,
            z: z_dims.first
        )
        @top_right = Hashie::Mash.new(
            x: x_dims.last,
            y: y_dims.last,
            z: z_dims.last
        )
    end

    def volume
        x_size = (top_right.x + 1) - bottom_left.x
        y_size = (top_right.y + 1) - bottom_left.y
        z_size = (top_right.z + 1) - bottom_left.z

        x_size * y_size * z_size
    end

    def intersects?(other_cuboid)
        if self.bottom_left.x > other_cuboid.top_right.x || self.top_right.x < other_cuboid.bottom_left.x
            return false
        elsif self.bottom_left.y > other_cuboid.top_right.y || self.top_right.y < other_cuboid.bottom_left.y
            return false
        elsif self.bottom_left.z > other_cuboid.top_right.z || self.top_right.z < other_cuboid.bottom_left.z
            return false
        end

        return true
    end

    def intersection(other_cuboid)
        return Cuboid.new(
            !self.on?,
            [[self.bottom_left.x, other_cuboid.bottom_left.x].max, [self.top_right.x, other_cuboid.top_right.x].min],
            [[self.bottom_left.y, other_cuboid.bottom_left.y].max, [self.top_right.y, other_cuboid.top_right.y].min],
            [[self.bottom_left.z, other_cuboid.bottom_left.z].max, [self.top_right.z, other_cuboid.top_right.z].min],
        )
    end
end

input = File.readlines(ARGV[0]).map(&:strip)
commands = input.map do |line|
    on = line.split(' ').first == 'on'
    dims = line.split(' ').last.split(',')
    x_dims = dims[0].split('=').last.split('..').map(&:to_i).sort
    y_dims = dims[1].split('=').last.split('..').map(&:to_i).sort
    z_dims = dims[2].split('=').last.split('..').map(&:to_i).sort

    [on, x_dims, y_dims, z_dims]
end

cuboids = []

commands.each do |on, x_dim, y_dim, z_dim|
    cuboid = Cuboid.new(on, x_dim, y_dim, z_dim)
    intersections = []
    cuboids.each do |c|
        intersections << c.intersection(cuboid) if c.intersects?(cuboid)
    end

    cuboids.concat(intersections)
    
    cuboids << cuboid if cuboid.on?
end

number_of_cubes_turned_on = cuboids.inject(0) do |total_cubes_turned_on, cuboid|
    if cuboid.on?
        total_cubes_turned_on += cuboid.volume
    else
        total_cubes_turned_on -= cuboid.volume
    end
end

puts number_of_cubes_turned_on
