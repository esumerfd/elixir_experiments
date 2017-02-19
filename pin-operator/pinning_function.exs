defmodule Greeter do
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting} #{name}"
      _       -> "I dont know you"
    end
  end
end

greet = Greeter.for("Ed", "Hello World")

IO.puts greet.("Ed")
IO.puts greet.("John")

