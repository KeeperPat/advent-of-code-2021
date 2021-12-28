require 'target_area'

describe TargetArea do
    before do
        @target_area = TargetArea.new(20..30, -10..-5)
    end

    describe 'include?' do
        it 'returns true if point is in the target area' do
            expect(@target_area.include?([20, -5])).to be true
        end

        it 'returns false if point is not in the target area' do
            expect(@target_area.include?([19, -11])).to be false
        end
    end

    describe 'missed?' do
        it 'returns false if the probe has not reached range' do
            @probe = Probe.new([7,2])
            expect(@target_area.missed?(@probe)).to be false
        end

        it 'returns true if the probe has passed maximum x' do
            @probe = Probe.new([31,1])
            @probe.step!
            expect(@target_area.missed_right?(@probe)).to be true
        end

        it 'returns true if the probe has passed minimum y' do
            @probe = Probe.new([30,-11])
            @probe.step!
            expect(@target_area.missed_left?(@probe)).to be true
        end
    end
end