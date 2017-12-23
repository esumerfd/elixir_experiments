defmodule User do
  defstruct [:name]
end

defimpl String.Chars, for: User do
  def to_string(user), do: "User #{user.name}"
end

defmodule Run do
  def run do
    IO.puts "Hello #{ %User{name: "José"} }"
  end
end

Run.run

