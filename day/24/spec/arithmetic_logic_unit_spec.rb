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

    describe 'process' do
        it 'returns registers' do
            @alu = ArithmeticLogicUnit.new
            expect(@alu.process!).to eq({})
        end

        it 'implements inp' do
            program = "inp w\n"
            @alu = ArithmeticLogicUnit.new(program)
            expect(@alu.process!([4])).to eq({'w' => 4})

        end

        describe 'add' do
            it 'works with a register and a number' do
                program = "add x 25\n"
                @alu = ArithmeticLogicUnit.new(program)
                expect(@alu.process!).to eq({'x' => 25})    
            end

            it 'works with two registers' do
                program = "add x -5\nadd y x"
                @alu = ArithmeticLogicUnit.new(program)
                expect(@alu.process!).to eq({
                    'x' => -5,
                    'y' => -5
                })    
            end
        end

        it 'implements mul'
        it 'implements div'
        it 'implements mod'
        it 'implements eql'
    end
end