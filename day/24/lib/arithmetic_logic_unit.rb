class ArithmeticLogicUnit
    attr_reader :commands, :registers

    def initialize(program = '')
        @registers = Hash.new(0)
        load_program(program)
    end

    def process!(input = [])
        commands.each do |command|
            case command[0]
            when 'inp'
                @registers[command[1]] = input.shift
            end
        end

        return registers
    end

    private
        def load_program(program)
            @commands = program.split("\n").map do |command|
                command.split(' ').map do |parameter|
                    is_integer?(parameter) ? parameter.to_i : parameter
                end
            end
        end

        def is_integer?(string)
            string.to_i.to_s == string
        end
end