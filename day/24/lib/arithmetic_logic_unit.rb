class ArithmeticLogicUnit
    attr_reader :commands, :registers

    def initialize(program = '')
        @registers = Hash.new(0)
        load_program(program)
    end

    def process!(input = [])
        @registers = Hash.new(0)

        commands.each do |command|
            second_param_value = (command[2].is_a?(Integer) ? command[2] : @registers[command[2]])
            case command[0]
            when 'inp'
                @registers[command[1]] = input.shift
            when 'add'
                @registers[command[1]] += second_param_value
            when 'mul'
                @registers[command[1]] *= second_param_value
            when 'div'
                @registers[command[1]] /= second_param_value
            when 'mod'
                @registers[command[1]] %= second_param_value
            when 'eql'
                if @registers[command[1]] == second_param_value
                    @registers[command[1]] = 1
                else
                    @registers[command[1]] = 0
                end
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
