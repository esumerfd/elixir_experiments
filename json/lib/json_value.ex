defmodule JsonValue do
  def parse(json_data) do
    JSON.decode(json_data)
  end

  def value_a(data) do
    elem(data, 1)["a"]
  end

  def value_b(data) do
    elem(data, 1)["b"]
  end

  def value_g(data) do
    elem(data, 1)["f"]["g"]
  end

  def value_list(data) do
    elem(data, 1)["c"]
  end


end
