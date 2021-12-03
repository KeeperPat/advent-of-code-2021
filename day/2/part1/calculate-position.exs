# See https://adventofcode.com/2021/day/3
defmodule Submarine do
    def move({"forward", distance}, {x, y}), do: {x+distance, y}
    def move({"up", distance}, {x, y}), do: {x, y-distance}
    def move({"down", distance}, {x, y}), do: {x, y+distance}
end

{:ok, commands} = File.read("input.txt")
 position = commands
    |> String.split("\n", trim: true)
    |> Enum.map(fn command -> String.split(command, " ", trim: true) end)
    |> Enum.map(fn command -> {Enum.at(command, 0), String.to_integer(Enum.at(command, 1))} end)
    |> Enum.reduce({0, 0}, &Submarine.move/2)

{x,y} = position
IO.puts("Horizontal Position: #{x}")
IO.puts("Depth: #{y}")
IO.puts(x*y)
