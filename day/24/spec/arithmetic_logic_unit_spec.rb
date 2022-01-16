require 'arithmetic_logic_unit'

describe ArithmeticLogicUnit do
    before do
        input_file = File.join(File.dirname(__FILE__), '../input/input.txt')
        @alu = ArithmeticLogicUnit.new(File.read(input_file))
    end

    describe 'new' do
        it 'initializes variables to 0' do
            expect(@alu.registers['w']).to eq(0)
            expect(@alu.registers['x']).to eq(0)
            expect(@alu.registers['y']).to eq(0)
            expect(@alu.registers['z']).to eq(0)
        end
    end

    describe 'commands' do
        it 'returns array of commands' do
            expect(@alu.commands.length).to eq(252)
            expect(@alu.commands[0]).to eq(['inp', 'w'])
            expect(@alu.commands[1]).to eq(['mul', 'x', 0])
        end
    end
end