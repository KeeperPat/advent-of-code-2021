#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/10
INPUT_FILE = ARGV[0]

commands = File.readlines(INPUT_FILE).map{|line| line.strip}

OPEN_CHARACTERS = ['(', '[', '{', '<']
CLOSE_CHARACTERS = [')', ']', '}', '>']
CHARACTER_MAPPING = Hash[CLOSE_CHARACTERS.zip(OPEN_CHARACTERS)]
CHARACTER_VALUES = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137
}

def first_corrupted_character(command)
    stack = []
    characters = command.split('')
    characters.each do |character|
        if OPEN_CHARACTERS.include?(character)
            stack.push(character)
        elsif CLOSE_CHARACTERS.include?(character) && CHARACTER_MAPPING[character] == stack.last
            stack.pop
        else
            return character
        end
    end

    return nil
end

puts commands.map{|command| first_corrupted_character(command)}.reject(&:nil?).map{|character| CHARACTER_VALUES[character]}.sum