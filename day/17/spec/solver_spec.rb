require 'solver'

describe Solver do
    before do
        @example_target_area = TargetArea.new(20..30, -10..-5)
        @example_solver = Solver.new(@example_target_area)

        @input_target_area = TargetArea.new(94..151, -156..-103)
        @input_solver = Solver.new(@input_target_area)
    end

    describe 'max_successful_height' do
        it 'should return the maximum height that can be reached and still hit the target area' do
            expect(@example_solver.max_successful_height).to eq(45)
        end

        it 'should return the solution to part 1' do
            expect(@input_solver.max_successful_height).to eq(12090)
        end
    end

    describe 'all_successful_starting_velocities' do
        it 'should return all the successful starting velocities' do
            expect(@example_solver.all_successful_starting_velocities.size).to eq(112)
        end

        it 'should return the solution to part 2' do
            expect(@input_solver.all_successful_starting_velocities.size).to eq(5059)
        end
    end
end