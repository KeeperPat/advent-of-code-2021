require 'deterministic_die'

describe DeterministicDie do
    before do
        @deterministic_die = DeterministicDie.new
    end

    describe 'roll!' do
        it 'increments on each roll from 1 to 100' do
            (1..100).each do |i|
                expect(@deterministic_die.roll!).to eq(i)
            end
        end

        it 'rolls over when it reaches 100' do
            100.times{@deterministic_die.roll!}

            expect(@deterministic_die.roll!).to eq(1)
        end
    end

    describe 'total_rolls' do
        it 'returns how many times it has been rolled in total' do
            expect(@deterministic_die.total_rolls).to eq(0)

            42.times{@deterministic_die.roll!}

            expect(@deterministic_die.total_rolls).to eq(42)
        end
    end
end