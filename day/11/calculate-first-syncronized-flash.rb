#!/usr/bin/env ruby
require './lib/octopus_grid'

# See https://adventofcode.com/2021/day/11
INPUT_FILE = ARGV[0]

octopus_grid = OctopusGrid.new(File.read(INPUT_FILE))

until(octopus_grid.all_flashed?) do
    octopus_grid.step!
end

puts octopus_grid.current_step
