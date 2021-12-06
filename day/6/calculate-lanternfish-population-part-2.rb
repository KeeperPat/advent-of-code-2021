#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/6
INPUT_FILE = ARGV[0]

# calculated using part 1
total_128_days_later = {
    0 => 94508,
    1 => 90763,
    2 => 79321,
    3 => 75638,
    4 => 67616,
    5 => 62475,
    6 => 58016,
    7 => 51564,
    8 => 49380,
}

population = File.readlines(ARGV[0]).first.split(',').map(&:to_i)

puts "Initial state: #{population.join(',')}"

128.times do |day|
    new_lanternfish = 0
    population = population.map do |lanternfish|
        if lanternfish == 0
            new_lanternfish += 1
            lanternfish = 6
        else
            lanternfish -=1
        end
    end
    population = population + Array.new(new_lanternfish, 8)
    #puts "After #{(day+1).to_s.rjust(2)} #{day == 0 ? 'day: ' : 'days:'} #{population.join(',')}"
    puts "Total After #{(day+1).to_s.rjust(2)} #{day == 0 ? 'day: ' : 'days:'} #{population.length}"
end

population.map{|lanternfish| total_128_days_later[lanternfish]}.sum

total = population.map{|lanternfish| total_128_days_later[lanternfish]}.sum

puts "Total Popluation After 256 Days: #{total}"