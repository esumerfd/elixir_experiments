defmodule MixNew do
  @moduledoc """
  Documentation for MixNew.
  """

  @doc """
  Hello world.

  ## Examples

      iex> MixNew.hello
      :world

  """
  def hello do
    IO.puts "Hello"

    world()
  end

  def world() do
    IO.puts "world"
  end
end
