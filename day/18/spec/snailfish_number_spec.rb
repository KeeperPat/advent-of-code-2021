require 'snailfish_number'

describe SnailfishNumber do
    describe 'new' do
        it 'raises ArgumentError if the argument contains invalid characters' do
            expect {SnailfishNumber.new('invalid')}.to raise_error('Invalid characters in snailfish number')
        end
    end

    describe 'to_s' do
        it 'returns the number as a string' do
            snailfish_number_string = '[[1,2],3]'
            expect(SnailfishNumber.new(snailfish_number_string).to_s).to eq(snailfish_number_string)
        end

        it 'returns the number as a string with spaces removed' do
            expect(SnailfishNumber.new('[[1, 2], 3]').to_s).to eq('[[1,2],3]')
        end
    end

    describe 'to_a' do
        it 'returns the number as an array' do
            expect(SnailfishNumber.new('[[1,2],3]').to_a).to eq([[1,2],3])
        end
    end

    describe '+' do
        it 'adds a SnailfishNumber' do
            sum = SnailfishNumber.new('[1,2]') + SnailfishNumber.new('[[3,4],5]')
            expect(sum.to_s).to eq('[[1,2],[[3,4],5]]')
        end

        it 'adds a String' do
            sum = SnailfishNumber.new('[1,2]') + '[[3,4],5]'
            expect(sum).to be_a(SnailfishNumber)
            expect(sum.to_s).to eq('[[1,2],[[3,4],5]]')
        end
    end

    describe 'split' do
        it 'has no effect on values less than 10' do
            expect(SnailfishNumber.new('[0,9]').split.to_s).to eq('[0,9]')
        end

        it 'replaces the first number less than 10 with a new pair where it rounds down the left elment and rounds up the right element' do
            expect(SnailfishNumber.new('[0,13]').split.to_s).to eq('[0,[6,7]]')
        end
    end

    describe 'explode' do
        it 'left-most number' do
            expect(SnailfishNumber.new('[[[[[9,8],1],2],3],4]').explode.to_s).to eq('[[[[0,9],2],3],4]')
        end

        it 'right-most number' do
            expect(SnailfishNumber.new('[7,[6,[5,[4,[3,2]]]]]').explode.to_s).to eq('[7,[6,[5,[7,0]]]]')
        end

        it 'numbers with values on both sides' do
            expect(SnailfishNumber.new('[[6,[5,[4,[3,2]]]],1]').explode.to_s).to eq('[[6,[5,[7,0]]],3]')
        end

        it 'explodes with values on both sides where right number is the first number' do
            expect(SnailfishNumber.new('[[[[0,7],4],[7,[[8,4],9]]],[1,1]]').explode.to_s).to eq('[[[[0,7],4],[15,[0,13]]],[1,1]]')
        end
    end

    describe 'reduce' do
        it 'returns the reduced number' do
            expect(SnailfishNumber.new('[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]').reduce.to_s).to eq('[[[[0,7],4],[[7,8],[6,0]]],[8,1]]')
        end
    end

    describe 'magnitude' do
        describe 'regular numbers' do
            it 'returns 3 times the left value' do
                expect(SnailfishNumber.new('[9,0]').magnitude).to eq(27)
            end

            it 'returns 2 times the right value' do
                expect(SnailfishNumber.new('[0,1]').magnitude).to eq(2)
            end

            it 'returns the sum of 3 times the left value and 2 times the right value' do
                expect(SnailfishNumber.new('[9,1]').magnitude).to eq(29)
            end
        end

        describe 'nested numbers' do
            it 'returns the correct value for one level of nesting' do
                expect(SnailfishNumber.new('[[9,1],[1,9]]').magnitude).to eq(129)
            end

            it 'returns the correct value for several levels of nesting' do
                expect(SnailfishNumber.new('[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]').magnitude).to eq(3488)
            end
        end
    end

    describe 'self.sum' do
        it 'sums the array of strings' do
            list = %w(
                [1,1]
                [2,2]
                [3,3]
                [4,4]
            )
            expect(SnailfishNumber.sum(list).to_s).to eq('[[[[1,1],[2,2]],[3,3]],[4,4]]')
        end

        it 'sums the array of strings reducing when appropriate' do
            list = %w(
                [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
                [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
                [[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
                [[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
                [7,[5,[[3,8],[1,4]]]]
                [[2,[2,2]],[8,[8,1]]]
                [2,9]
                [1,[[[9,3],9],[[9,0],[0,7]]]]
                [[[5,[7,4]],7],1]
                [[[[4,2],2],6],[8,7]]
            )
            expect(SnailfishNumber.sum(list).to_s).to eq('[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]')
        end
    end
end