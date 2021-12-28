class Launch
    attr_reader :probe

    def initialize(probe, target_area)
        @probe = probe
        @target_area = target_area
    end

    def outcome
        while !@target_area.include?(@probe.position) && !@target_area.missed?(@probe) do
            @probe.step!
        end

        if @target_area.include?(@probe.position)
            return :success
        elsif @target_area.missed_left?(@probe)
            return :missed_left
        elsif @target_area.missed_right?(@probe)
            return :missed_right
        end
    end
end