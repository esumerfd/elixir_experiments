add_one = &(&1 + 1)
IO.puts add_one.(44)

output = &(IO.puts "#{&1} #{&2}")
output.("Hello", "World")

add_subtract = &{ div(&1, &2), rem(&1, &2) }
result = add_subtract.(10, 3)
IO.puts "first element #{ elem(result,0) }, second element #{elem(result,1)}"

len = &length/1
count = &Enum.count/1
IO.puts "length #{len.([1,2,3])} : Count #{count.([1,2,3,4])}"

mapped = Enum.map [1,2,3,4], &(&1 * 2)
IO.puts "mapped #{inspect mapped}"

