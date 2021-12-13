require 'set'
require 'pp'

class Graph
    def initialize(input)
        @edges = input.split("\n").map{|row| row.split('-')}
    end

    def paths(start_node, destination_node)
        paths = Set.new([])

        traverse(start_node, destination_node, [start_node], paths)

        return paths
    end

    def to_s
        @edges.map{|nodes| nodes.join('-')}.join("\n") + "\n"
    end

    private
        def neighbors_for(node)
            @edges.select{|edge| edge.include?(node)}.map{|edge| edge.reject{|n| n == node}}.flatten
        end

        def traverse(current_node, destination_node, current_path, paths)
            if current_node == destination_node
                paths << current_path.join(',')
            else
                neighbors_for(current_node).reject{|node| ineligible_to_visit?(node, current_path)}.each do |node|
                    traverse(node, destination_node, current_path.dup << node, paths)
                end
            end
        end

        def ineligible_to_visit?(node, current_path)
            node == 'start' ||
            small_cave?(node) && small_cave_visited_twice?(current_path) && current_path.include?(node)
        end

        def small_cave_visited_twice?(current_path)
            current_path.select{|cave| small_cave?(cave)}.size > current_path.select{|cave| small_cave?(cave)}.uniq.size
        end

        def small_cave?(node)
            node == node.downcase
        end

end