#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/1
input = File.readlines(ARGV[0]).map(&:strip)

column_counts = input.map{|reading| reading.split('')}.transpose.map{|column| column.group_by(&:itself).transform_values(&:count)}

gamma = column_counts.map{|column_count| column_count.sort_by{|k,v| v}[1].first}.join
epsilon = column_counts.map{|column_count| column_count.sort_by{|k,v| v}[0].first}.join

puts "Gamma: '#{gamma}' (#{gamma.to_i(2)})"
puts "Epsilon: '#{epsilon}' (#{epsilon.to_i(2)})"
puts "Power Consumption = #{gamma.to_i(2) * epsilon.to_i(2)}"