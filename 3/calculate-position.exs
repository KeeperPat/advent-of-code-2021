# See https://adventofcode.com/2021/day/3
defmodule Submarine do
    def move(command, starting_position) do
        case command do
            {"forward", x} ->
                [Enum.at(starting_position, 0) + x, Enum.at(starting_position, 1)]
            {"up", y} ->
                [Enum.at(starting_position, 0), Enum.at(starting_position, 1) - y]
            {"down", y} ->
                [Enum.at(starting_position, 0), Enum.at(starting_position, 1) + y]
        end
    end
end

{:ok, commands} = File.read("input.txt")
 position = commands \
    |> String.split("\n", trim: true) \
    |> Enum.map(fn command -> String.split(command, " ", trim: true) end) \
    |> Enum.map(fn command -> {Enum.at(command, 0), String.to_integer(Enum.at(command, 1))} end) \
    |> Enum.reduce([0, 0], &Submarine.move/2)

IO.puts("Horizontal Position: #{Enum.at(position, 0)}")
IO.puts("Depth: #{Enum.at(position, 1)}")
IO.puts(Enum.product(position))
