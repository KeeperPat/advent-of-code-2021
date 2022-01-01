require 'hashie/mash'

class Game
    attr_reader :player_one, :player_two, :die

    def initialize(input)
        @die = DeterministicDie.new

        @player_one = Hashie::Mash.new(name: 'Player One', score: 0)
        @player_two = Hashie::Mash.new(name: 'Player Two', score: 0)

        positions = input.split("\n").map{|line| line.split(':')[1].strip.to_i}
        @player_one.position = positions[0]
        @player_two.position = positions[1]

        @current_player = player_one
    end

    def winner?
        [player_one.score, player_two.score].max >= 1000
    end

    def play_turn!
        3.times do
            @current_player.position += die.roll!
            @current_player.position = (@current_player.position % 10)
            @current_player.position = 10 if @current_player.position == 0
        end
        @current_player.score += @current_player.position

        if @current_player == player_one
            @current_player = player_two
        else
            @current_player = player_one
        end
    end

    def losing_player
        winner? && [player_one, player_two].find{|player| player.score < 1000}
    end
end
