class CommandParser
    def self.parse(hex_transmission)
        binary_transmission = pad(hex_transmission.hex.to_s(2), hex_transmission)

        return parse_binary(binary_transmission)
    end

    def self.sum_versions(parsed_commands)
        versions = []
        versions << parsed_commands[:version]
        if parsed_commands.include?(:subpackets)
            versions << parsed_commands[:subpackets].map{|subpacket| sum_versions(subpacket)}
        end

        return versions.flatten.sum
    end

    private
        def self.pad(binary_transmission, hex_transmission)
            zero_padding = "0" * ((hex_transmission.length * 4)- binary_transmission.length)

            return zero_padding + binary_transmission
        end

        def self.parse_binary(binary_transmission)
            version = binary_transmission.slice!(0...3).to_i(2)
            type_id = binary_transmission.slice!(0...3).to_i(2)

            if type_id == 4
                return parse_literal(version, type_id, binary_transmission)
            else
                return parse_command(version, type_id, binary_transmission)
            end
        end

        def self.parse_literal(version, type_id, binary_transmission)
            last_group = false
            binary_value = ''
            until(last_group) do
                last_group = binary_transmission.slice!(0).to_i == 0
                binary_value << binary_transmission.slice!(0...4)
            end
            return {
                version: version,
                type_id: type_id,
                value: binary_value.to_i(2)
            }
        end

        def self.parse_command(version, type_id, binary_transmission)
            length_type_id = binary_transmission.slice!(0).to_i(2)

            if length_type_id == 0
                return parse_command_type_0(version, type_id, binary_transmission)
            elsif length_type_id == 1
                return parse_command_type_1(version, type_id, binary_transmission)
            end
        end

        def self.parse_command_type_0(version, type_id, binary_transmission)
            subpackets_length = binary_transmission.slice!(0...15).to_i(2)
            subpackets_binary_transmission = binary_transmission.slice!(0...subpackets_length)
            subpackets = []
            while subpackets_binary_transmission.length > 0
                subpackets << parse_binary(subpackets_binary_transmission)
            end

            return {
                version: version,
                type_id: type_id,
                length_type_id: 0,
                subpackets_length: subpackets_length,
                subpackets: subpackets
            }
        end

        def self.parse_command_type_1(version, type_id, binary_transmission)
            number_of_subpackets = binary_transmission.slice!(0...11).to_i(2)
            subpackets = []
            number_of_subpackets.times do
                subpackets << parse_binary(binary_transmission)
            end

            return {
                version: version,
                type_id: type_id,
                length_type_id: 1,
                number_of_subpackets: number_of_subpackets,
                subpackets: subpackets
            }
        end
end