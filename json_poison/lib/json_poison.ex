defmodule JsonFieldG do
  defstruct field_g: ""
end

defmodule JsonFields do
  defstruct field_a: "", field_b: "", field_c: "", field_f: %JsonFieldG{}
end

defmodule JsonPoison do
  def parse(json_text) do
    json_text
    |> Poison.decode(as: %JsonFields{})
    |> check
  end

  defp check({:ok, data}) do
    data
  end

  defp check({:error, message, _}) do
    "BAD DATA: #{message}"
  end
end
