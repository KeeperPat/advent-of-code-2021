#!/usr/bin/env ruby

# See https://adventofcode.com/2021/day/10
INPUT_FILE = ARGV[0]

commands = File.readlines(INPUT_FILE).map{|line| line.strip}

OPEN_CHARACTERS = ['(', '[', '{', '<']
CLOSE_CHARACTERS = [')', ']', '}', '>']
CLOSE_TO_OPEN_CHARACTER_MAPPING = Hash[CLOSE_CHARACTERS.zip(OPEN_CHARACTERS)]
OPEN_TO_CLOSE_CHARACTER_MAPPING = Hash[OPEN_CHARACTERS.zip(CLOSE_CHARACTERS)]
CHARACTER_VALUES = {
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4
}

def first_corrupted_character(command)
    stack = []
    characters = command.split('')
    characters.each do |character|
        if OPEN_CHARACTERS.include?(character)
            stack.push(character)
        elsif CLOSE_CHARACTERS.include?(character) && CLOSE_TO_OPEN_CHARACTER_MAPPING[character] == stack.last
            stack.pop
        else
            return character
        end
    end

    return nil
end

def complete(command)
    stack = []
    characters = command.split('')
    characters.each do |character|
        if OPEN_CHARACTERS.include?(character)
            stack.push(character)
        elsif CLOSE_CHARACTERS.include?(character) && CLOSE_TO_OPEN_CHARACTER_MAPPING[character] == stack.last
            stack.pop
        end
    end
    stack.reverse.map{|character| OPEN_TO_CLOSE_CHARACTER_MAPPING[character]}
end

def score(completion)
    completion.inject(0) do |score, character|
        (score * 5) + CHARACTER_VALUES[character]
    end
end

incomplete_lines = commands.select{|command| first_corrupted_character(command).nil?}
completions = incomplete_lines.map{|incomplete_command| complete(incomplete_command)}
scores = completions.map{|completion| score(completion)}

puts scores.sort[scores.length/2]