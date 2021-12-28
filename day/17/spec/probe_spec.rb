require 'probe'

describe Probe do
    before do
        @probe = Probe.new([7, 2])
    end

    describe 'step' do
        it 'starts at 0' do
            expect(@probe.step).to eq(0)
        end
    end

    describe 'velocity' do
        it 'returns velocity' do
            expect(@probe.velocity).to eq([7, 2])
        end
    end

    describe 'position' do
        it 'starts at [0,0]' do
            expect(@probe.position).to eq([0,0])
        end
    end

    describe 'step!' do
        before do
            @probe.step!
        end

        it 'increments step' do
            expect(@probe.step).to eq(1)
        end

        it 'updates velocity with drag' do
            expect(@probe.velocity).to eq([6, 1])
        end

        it 'updates position' do
            expect(@probe.position).to eq([7, 2])
        end
    end
end