require 'launch'

describe Launch do
    before do
        @probe = Probe.new([7,2])
        @target_area = TargetArea.new(20..30, -10..-5)
        @launch = Launch.new(@probe, @target_area)
    end

    describe 'probe' do
        it 'returns probe' do
            expect(@launch.probe).to eq(@probe)
        end
    end

    describe 'outcome' do
        describe 'trajectory that hits target area' do
            it 'returns :success' do
                expect(@launch.outcome).to eq(:success)
            end
        end

        describe 'trajectory that misses target area to the right' do
            before do
                @launch = Launch.new(Probe.new([17, -4]), @target_area)
            end

            it 'returns :missed_right' do
                expect(@launch.outcome).to eq(:missed)
            end
        end

        describe 'trajectory that misses target area to the left' do
            before do
                @launch = Launch.new(Probe.new([30, -11]), @target_area)
            end

            it 'returns :missed_left' do
                expect(@launch.outcome).to eq(:missed)
            end
        end
    end

    describe 'max_height' do
        it 'returns max height reached during launch for successful outcomes' do
            @launch = Launch.new(Probe.new([6, 9]), @target_area)
            expect(@launch.outcome).to eq(:success)

            expect(@launch.max_height).to eq(45)
        end
    end
end