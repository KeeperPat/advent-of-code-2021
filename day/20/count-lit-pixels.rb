#!/usr/bin/env ruby
require './lib/trench_map'

# See https://adventofcode.com/2021/day/20
INPUT_FILE = ARGV[0]
STEPS = ARGV[1].to_i

trench_map = TrenchMap.new(File.read(INPUT_FILE))

STEPS.times do |step|
    trench_map.enhance!
end

puts trench_map.light_pixels.size
