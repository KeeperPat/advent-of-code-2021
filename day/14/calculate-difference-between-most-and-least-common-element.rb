#!/usr/bin/env ruby
require 'pp'

# See https://adventofcode.com/2021/day/14
INPUT_FILE = ARGV[0]
STEPS = ARGV[1].to_i

polymer, pair_insertion_rules = File.read(INPUT_FILE).split("\n\n")

pair_insertion_rules = pair_insertion_rules.split("\n").map{|rule| rule.split(' -> ')}.to_h

pairs = polymer.chars.each_cons(2).map(&:join)
pair_counts = pairs.uniq.map{|pair| [pair, pairs.count(pair)]}.to_h
character_counts = Hash.new(0).merge(polymer.chars.uniq.map{|char| [char, polymer.count(char)]}.to_h)

STEPS.times do |step|
    next_pair_counts = Hash.new(0)

    pair_counts.each do |pair, count|
        left_char, right_char = pair.split('')
        middle_char = pair_insertion_rules[pair]
        next_pair_counts[left_char + middle_char] += count
        next_pair_counts[middle_char + right_char] += count
        character_counts[middle_char] += count
    end

    pair_counts = next_pair_counts
end

puts character_counts.values.max - character_counts.values.min