translate = fn 
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, arg) -> arg
end

IO.puts "FizzBuzz = #{translate.(0,0,"ignored")}"
IO.puts "Fizz     = #{translate.(0,1,"ignored")}"
IO.puts "Buzz     = #{translate.(1,0,"ignored")}"
IO.puts "third    = #{translate.(1,1,"third")}"

fizzbuzz = fn 
  (n) -> IO.puts translate.(rem(n,3), rem(n,5), n) 
end

fizzbuzz.(10)
fizzbuzz.(11)
fizzbuzz.(12)
fizzbuzz.(13)
fizzbuzz.(14)
fizzbuzz.(15)
fizzbuzz.(16)

