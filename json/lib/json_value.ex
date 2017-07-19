defmodule JsonValue do
  def parse(json_data) do
    JSON.decode(json_data)
  end

  def value_a({:ok, %{"a" => value}}) do
    value
  end

  def value_b({:ok, %{"b" => value}}) do
    value
  end

  def value_g({:ok, %{"f" => %{"g" => value}}}) do
    value
  end

  def value_list({:ok, %{"c" => value}}) do
    value
  end
end

