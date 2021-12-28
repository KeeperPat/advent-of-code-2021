class Launch
    attr_reader :probe, :max_height

    def initialize(probe, target_area)
        @probe = probe
        @target_area = target_area
        @max_height = 0
    end

    def outcome
        while !@target_area.include?(@probe.position) && !@probe.missed?(@target_area) do
            @probe.step!
            @max_height = [@max_height, @probe.position[1]].max
        end

        if @target_area.include?(@probe.position)
            return :success
        elsif @probe.missed?(@target_area)
            return :missed
        end
    end
end