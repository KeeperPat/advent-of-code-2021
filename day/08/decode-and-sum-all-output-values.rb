#!/usr/bin/env ruby

require 'set'

# See https://adventofcode.com/2021/day/6
INPUT_FILE = ARGV[0]

entries = File.readlines(INPUT_FILE).map{|line| line.strip.split(' | ').map(&:split)}

def decode(signal_patterns)
    code = []

    segment_mapping = %w(abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg)

    code[1] = signal_patterns.detect{|signal_pattern| signal_pattern.length == 2}
    code[4] = signal_patterns.detect{|signal_pattern| signal_pattern.length == 4}
    code[7] = signal_patterns.detect{|signal_pattern| signal_pattern.length == 3}
    code[8] = signal_patterns.detect{|signal_pattern| signal_pattern.length == 7}

    e_segment = %w(a b c d e f g).map{|letter| [letter, signal_patterns.map{|digit| digit.split('')}.flatten.count{|l| l == letter}]}.detect{|letter, count| count == 4}[0]

    characters_in_9 = Set.new(%w(a b c d e f g) - [e_segment])
    code[9] = signal_patterns.map{|s| Set.new(s.split(''))}.detect{|s| s == characters_in_9}.to_a.join

    b_segment = %w(a b c d e f g).map{|letter| [letter, signal_patterns.map{|digit| digit.split('')}.flatten.count{|l| l == letter}]}.detect{|letter, count| count == 6}[0]
    f_segment = %w(a b c d e f g).map{|letter| [letter, signal_patterns.map{|digit| digit.split('')}.flatten.count{|l| l == letter}]}.detect{|letter, count| count == 9}[0]
    g_segment = (Set.new(code[9].chars) - Set.new(code[4].chars) - Set.new(code[7].chars)).to_a.join
    d_segment = %w(a b c d e f g).map{|letter| [letter, signal_patterns.map{|digit| digit.split('')}.flatten.count{|l| l == letter}]}.detect{|letter, count| count == 7 && letter != g_segment}[0]

    characters_in_0 = Set.new(code[8].split('') - [d_segment])
    code[0] = signal_patterns.map{|s| Set.new(s.split(''))}.detect{|s| s == characters_in_0}.to_a.join

    characters_in_2 = Set.new(code[8].split('') - [b_segment, f_segment])
    code[2] = signal_patterns.map{|s| Set.new(s.split(''))}.detect{|s| s == characters_in_2}.to_a.join

    characters_in_3 = Set.new(code[8].split('') - [b_segment, e_segment])
    code[3] = signal_patterns.map{|s| Set.new(s.split(''))}.detect{|s| s == characters_in_3}.to_a.join

    characters_in_6 = Set.new(code[8].split('') - code[1].split('') + [f_segment])
    code[6] = signal_patterns.map{|s| Set.new(s.split(''))}.detect{|s| s == characters_in_6}.to_a.join

    code[5] = (signal_patterns - code).first


    Hash[code.map.with_index{|signal, value| [Set.new(signal.split('')), value]}]
end

values = entries.map do |signal_patterns, output_values|
    lookup_table = decode(signal_patterns)
    output_value = output_values.map{|signal| lookup_table[Set.new(signal.split(''))]}.join
end.map(&:to_i)

puts "Sum of all output values: #{values.sum}"