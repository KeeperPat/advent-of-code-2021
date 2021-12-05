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
    boards = boards.reject(&:winner?) unless boards.length == 1
    break if boards.length == 1 && boards.first.winner?
end

puts boards.first.score