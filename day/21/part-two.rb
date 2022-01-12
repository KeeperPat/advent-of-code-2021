#!/usr/bin/env ruby
require 'pp'
require 'hashie/mash'

steps = {
    3=>1,
    4=>3,
    5=>6,
    6=>7,
    7=>6,
    8=>3,
    9=>1
}

PLAYER_ONE = 0
PLAYER_TWO = 1 
current_player = PLAYER_ONE

winning_game_count = [0, 0]

active_games = Hash.new(0)
active_games[[Hashie::Mash.new(name: 'Player One', score: 0, position: 9), Hashie::Mash.new(name: 'Player Two', score: 0, position: 4)]] = 1

while active_games.values.sum > 0 do
    new_active_games = active_games.dup
    active_games.each do |players, games_count|
        new_active_games[players] -= games_count
        player_one, player_two = players
        if current_player == PLAYER_ONE
            steps.each do |steps, new_games_count|
                new_position = player_one.position + steps
                new_position = (new_position % 10)
                new_position = 10 if new_position == 0
                new_score = player_one.score + new_position

                if new_score >= 21
                    winning_game_count[PLAYER_ONE] += new_games_count * games_count
                else
                    new_active_games[[
                        Hashie::Mash.new(name: 'Player One', score: new_score, position: new_position), 
                        player_two
                    ]] += new_games_count * games_count
                end
            end
        else
            steps.each do |steps, new_games_count|
                new_position = player_two.position + steps
                new_position = (new_position % 10)
                new_position = 10 if new_position == 0
                new_score = player_two.score + new_position

                if new_score >= 21
                    winning_game_count[PLAYER_TWO] += new_games_count * games_count
                else
                    new_active_games[[
                        player_one, 
                        Hashie::Mash.new(name: 'Player Two', score: new_score, position: new_position)
                    ]] += new_games_count * games_count
                end
            end
        end
    end

    active_games = new_active_games

    puts "#{active_games.values.sum} total games"

    current_player = (current_player == PLAYER_ONE ? PLAYER_TWO : PLAYER_ONE)
end

puts "Player One wins: #{winning_game_count[PLAYER_ONE]}\nPlayer Two wins: #{winning_game_count[PLAYER_TWO]}"