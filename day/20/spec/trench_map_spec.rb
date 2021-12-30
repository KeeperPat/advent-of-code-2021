require 'trench_map'

describe TrenchMap do
    before do
        sample_input_file_path = File.join(File.dirname(__FILE__), '../input/sample-input.txt')
        @trench_map = TrenchMap.new(File.read(sample_input_file_path))
    end

    describe 'image_enhancement_algorithm' do
        it 'returns the image_enhancement_algorithm' do
            expect(@trench_map.image_enhancement_algorithm).to eq('..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#'.chars)
        end
    end

    describe 'image' do
        it 'returns the image_enhancement_algorithm' do
            initial_image = [
                %w(# . . # .),
                %w(# . . . .),
                %w(# # . . #),
                %w(. . # . .),
                %w(. . # # #)
            ]
            expect(@trench_map.image).to eq(initial_image)
        end
    end

    describe 'binary_value_at' do
        it 'returns the binary file at given coordinates' do
            expect(@trench_map.binary_value_at(2,2)).to eq(34)
        end
    end
end