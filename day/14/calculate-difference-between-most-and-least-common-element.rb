#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/14
def next_step(polymer, pair_insertion_rules)
    polymer.chars.each_cons(2).map.with_index do |(first, second), index|
        insertion = pair_insertion_rules[[first, second].join]
        "#{first}#{insertion}#{second if index == polymer.length-2}"
    end.join
end

INPUT_FILE = ARGV[0]
STEPS = ARGV[1].to_i

polymer, pair_insertion_rules = File.read(INPUT_FILE).split("\n\n")

pair_insertion_rules = Hash[pair_insertion_rules.split("\n").map{|rule| rule.split(' -> ')}]

STEPS.times do |step|
    polymer = next_step(polymer, pair_insertion_rules)
end

character_counts = polymer.chars.uniq.map{|char| [char, polymer.count(char)]}

puts character_counts.max_by{|char, count| count}[1] - character_counts.min_by{|char, count| count}[1]