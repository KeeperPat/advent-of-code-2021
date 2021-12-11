#!/usr/bin/env ruby
require './lib/octopus_grid'

# See https://adventofcode.com/2021/day/11
INPUT_FILE = ARGV[0]
STEPS = ARGV[1].to_i

def display_octopus_grid(octopus_grid)
    puts "After Step #{octopus_grid.current_step}"
    puts "#{octopus_grid.total_flashes} total flashes"
    puts ""
    puts octopus_grid
    puts ""
end

octopus_grid = OctopusGrid.new(File.read(INPUT_FILE))

STEPS.times do |step|
    octopus_grid.step!
    #display_octopus_grid(octopus_grid)
end

puts octopus_grid.total_flashes
