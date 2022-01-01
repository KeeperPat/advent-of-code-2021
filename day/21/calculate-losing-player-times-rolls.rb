#!/usr/bin/env ruby
require './lib/deterministic_die'
require './lib/game'

# See https://adventofcode.com/2021/day/21
INPUT_FILE = ARGV[0]
STEPS = ARGV[1].to_i

game = Game.new(File.read(INPUT_FILE))

until game.winner? do
    game.play_turn!
end

puts game.losing_player.score * game.die.total_rolls
