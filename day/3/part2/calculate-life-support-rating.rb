#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/1
input = File.readlines(ARGV[0]).map(&:strip)

oxygen_generator_ratings = input.dup
(0...oxygen_generator_ratings.first.length).to_a.each do |bit_position|
    # Count frequency at current bit position
    frequencies = oxygen_generator_ratings.map{|reading| reading.split('')}.transpose.map{|column| column.group_by(&:itself).transform_values(&:count)}[bit_position]
    
    # Determine most common value, ties are "1"
    most_common_value = frequencies["1"] >= frequencies["0"] ? "1" : "0"

    # Reject all that don't match the mask
    oxygen_generator_ratings.select!{|rating| rating[bit_position] == most_common_value}

    # Stop when only potential rating left
    break if oxygen_generator_ratings.length == 1
end
oxygen_generator_rating = oxygen_generator_ratings.first

c02_scrubber_ratings = input.dup
(0...c02_scrubber_ratings.first.length).to_a.each do |bit_position|
    # Count frequency at current bit position
    frequencies = c02_scrubber_ratings.map{|reading| reading.split('')}.transpose.map{|column| column.group_by(&:itself).transform_values(&:count)}[bit_position]
    
    # Determine least common value, ties are "0"
    least_common_value = frequencies["1"] < frequencies["0"] ? "1" : "0"

    # Reject all that don't match the mask
    c02_scrubber_ratings.select!{|rating| rating[bit_position] == least_common_value}

    # Stop when only potential rating left
    break if c02_scrubber_ratings.length == 1
end
c02_scrubber_rating = c02_scrubber_ratings.first

puts "Oxygen Generator Rating: '#{oxygen_generator_rating}' (#{oxygen_generator_rating.to_i(2)})"
puts "CO2 Scrubber Rating: '#{c02_scrubber_rating}' (#{c02_scrubber_rating.to_i(2)})"
puts "Power Consumption = #{oxygen_generator_rating.to_i(2) * c02_scrubber_rating.to_i(2)}"