defmodule Multiline do

  def one() do
    IO.puts("one part one")
    IO.puts("one part two")
  end

  def two(), do: IO.puts("two")

  def three(), do: (
    IO.puts("three part one")
    IO.puts("three part two")
  )

  def four() do IO.puts("four") end
end

defmodule SingleModule, do: def five(), do: ( IO.puts("five part one"); IO.puts("five part two") )
