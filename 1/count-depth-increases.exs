# See https://adventofcode.com/2021/day/1
{:ok, depth_readings} = File.read("input.txt")
depth_readings = depth_readings |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)

number_of_times_depth_increases = depth_readings
  |> Enum.chunk_every(2, 1, :discard)
  |> Enum.map(fn x -> if List.last(x) > List.first(x), do: 1, else: 0 end)
  |> Enum.sum

IO.puts(number_of_times_depth_increases)
