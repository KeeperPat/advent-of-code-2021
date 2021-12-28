require 'target_area'

describe TargetArea do
    before do
        @target_area = TargetArea.new(20..30, -10..-5)
    end

    describe 'include?' do
        it 'returns true if point is in the target area' do
            expect(@target_area.include?(20, -5)).to be true
        end

        it 'returns false if point is not in the target area' do
            expect(@target_area.include?(19, -11)).to be false
        end
    end
end