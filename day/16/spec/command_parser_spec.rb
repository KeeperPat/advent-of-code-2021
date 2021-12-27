require 'command_parser'

describe CommandParser do
    before do
    end

    describe 'parse' do
        it "should parse a transmission with a single literal packet" do
            expect(CommandParser.parse('D2FE28')).to eq({
                version: 6,
                type_id: 4,
                value: 2021
            })
        end

        describe 'operator packets' do
            it 'should parse a single packet with length type 0' do
                expect(CommandParser.parse('38006F45291200')).to eq({
                    version: 1,
                    type_id: 6,
                    length_type_id: 0,
                    subpackets_length: 27,
                    subpackets: [
                        {
                            version: 6,
                            type_id: 4,
                            value: 10            
                        }, {
                            version: 2,
                            type_id: 4,
                            value: 20
                        }
                    ]
                })    
            end

            it 'should parse a single packet with length type 1' do
                expect(CommandParser.parse('EE00D40C823060')).to eq({
                    version: 7,
                    type_id: 3,
                    length_type_id: 1,
                    number_of_subpackets: 3,
                    subpackets: [
                        {
                            version: 2,
                            type_id: 4,
                            value: 1            
                        }, {
                            version: 4,
                            type_id: 4,
                            value: 2
                        }, {
                            version: 1,
                            type_id: 4,
                            value: 3
                        }
                    ]
                })
            end
        end
    end

    describe 'sum_versions' do
        it 'sum all nested packets' do
            expect(CommandParser.sum_versions(CommandParser.parse('D2FE28'))).to eq(6)
            expect(CommandParser.sum_versions(CommandParser.parse('8A004A801A8002F478'))).to eq(16)
            expect(CommandParser.sum_versions(CommandParser.parse('620080001611562C8802118E34'))).to eq(12)
            expect(CommandParser.sum_versions(CommandParser.parse('C0015000016115A2E0802F182340'))).to eq(23)
            expect(CommandParser.sum_versions(CommandParser.parse('A0016C880162017C3686B18A3D4780'))).to eq(31)
        end
    end

    describe 'calculate' do
        it 'finds sums for type_id 0 commands' do
            # finds the sum of 1 and 2, resulting in the value 3.
            expect(CommandParser.calculate(CommandParser.parse('C200B40A82'))).to eq(3)
        end

        it 'finds products for type_id 1 commands' do
            # finds the product of 6 and 9, resulting in the value 54.
            expect(CommandParser.calculate(CommandParser.parse('04005AC33890'))).to eq(54)
        end

        it 'finds the minimum for type_id 2 commands' do
            # finds the minimum of 7, 8, and 9, resulting in the value 7.
            expect(CommandParser.calculate(CommandParser.parse('880086C3E88112'))).to eq(7)
        end

        it 'finds maximum for type_id 3 commands' do
            # finds the maximum of 7, 8, and 9, resulting in the value 9.
            expect(CommandParser.calculate(CommandParser.parse('CE00C43D881120'))).to eq(9)
        end

        it 'returns greater than boolean for type_id 5 commands' do
            # produces 1, because 5 is less than 15.
            expect(CommandParser.calculate(CommandParser.parse('D8005AC2A8F0'))).to eq(1)
        end

        it 'returns less than boolean for type_id 6 commands' do
            # produces 0, because 5 is not greater than 15.
            expect(CommandParser.calculate(CommandParser.parse('F600BC2D8F'))).to eq(0)
        end

        it 'returns equal to boolean for type_id 7 commands' do
            # produces 0, because 5 is not equal to 15.
            expect(CommandParser.calculate(CommandParser.parse('9C005AC2F8F0'))).to eq(0)
        end

        it 'handles nested commands' do
            # produces 1, because 1 + 3 = 2 * 2.
            expect(CommandParser.calculate(CommandParser.parse('9C0141080250320F1802104A08'))).to eq(1)
        end
    end
end