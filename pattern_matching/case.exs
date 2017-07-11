defmodule Case do

  def check(a, b) do
    case [a,b] do
      [_,0] -> 0
      [a,b] -> a + b
    end
  end
end

IO.puts(">>>> #{Case.check(1,2)}")
IO.puts(">>>> #{Case.check(1,0)}")
