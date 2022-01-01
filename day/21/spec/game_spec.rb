require 'game'

describe Game do
    before do
        sample_input_file_path = File.join(File.dirname(__FILE__), '../input/sample-input.txt')
        @game = Game.new(File.read(sample_input_file_path))
    end

    describe 'new' do
        it 'sets starting positions correctly' do
            expect(@game.player_one.name).to eq('Player One')
            expect(@game.player_one.position).to eq(4)
            expect(@game.player_one.score).to eq(0)

            expect(@game.player_two.name).to eq('Player Two')
            expect(@game.player_two.position).to eq(8)
            expect(@game.player_two.score).to eq(0)
        end
    end

    describe 'die' do
        it 'returns the die' do
            expect(@game.die.total_rolls).to eq(0)
        end
    end

    describe 'play_turn!' do
        it 'plays a single turn' do
            @game.play_turn!

            expect(@game.die.total_rolls).to eq(3)
            expect(@game.player_one.score).to eq(10)
        end
    end

    describe 'winner?' do
        it 'returns false if no one has won the game' do
            expect(@game.winner?).to be false
        end

        it 'returns true if someone has one the game' do
            331.times do
                @game.play_turn!
            end

            expect(@game.winner?).to be true
        end
    end

    describe 'losing_player' do
        it 'returns the losing player' do
            331.times do
                @game.play_turn!
            end

            expect(@game.losing_player.name).to eq('Player Two')
            expect(@game.losing_player.score).to eq(745)
        end
    end
end