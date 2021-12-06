#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/6
INPUT_FILE = ARGV[0]
DAYS_TO_SIMULATE = ARGV[1] ? ARGV[1].to_i : 80

population = File.readlines(ARGV[0]).first.split(',').map(&:to_i)

puts "Initial state: #{population.join(',')}"

DAYS_TO_SIMULATE.times do |day|
    new_lanternfish = 0
    population = population.map do |lanternfish|
        if lanternfish == 0
            new_lanternfish += 1
            lanternfish = 6
        else
            lanternfish -=1
        end
    end
    new_lanternfish.times{population << 8}
    puts "After #{(day+1).to_s.rjust(2)} #{day == 0 ? 'day: ' : 'days:'} #{population.join(',')}"
end

puts "Total Popluation After #{DAYS_TO_SIMULATE} Days: #{population.length}"