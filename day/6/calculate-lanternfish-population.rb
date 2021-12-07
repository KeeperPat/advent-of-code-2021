#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/6
INPUT_FILE = ARGV[0]
DAYS_TO_SIMULATE = ARGV[1] ? ARGV[1].to_i : 80

population = File.readlines(INPUT_FILE).first.split(',').map(&:to_i)

lanternfish_population_by_age = Array.new(9, 0)
population.each{|age| lanternfish_population_by_age[age] += 1}

DAYS_TO_SIMULATE.times do
    lanternfish_population_by_age[8] = lanternfish_population_by_age.shift
    lanternfish_population_by_age[6] += lanternfish_population_by_age[8]
end

puts "Total Popluation After #{DAYS_TO_SIMULATE} Days: #{lanternfish_population_by_age.sum}"
