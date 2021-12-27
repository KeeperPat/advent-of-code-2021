#!/usr/bin/env ruby
require './lib/board'


# See https://adventofcode.com/2021/day/4
input = File.readlines(ARGV[0]).map(&:strip)

numbers_to_play = input.shift.split(',').map(&:to_i)
boards = input.each_slice(6).map{|rows| rows.reject{|row| row == ""}.join("\n")}.map{|board_input| Board.new(board_input)}

score = numbers_to_play.each do |number_to_play|
    boards.each do |board|
        board.play!(number_to_play)
    end
    break if boards.detect{|board| board.winner?}
end

puts boards.detect{|board| board.winner?}.score