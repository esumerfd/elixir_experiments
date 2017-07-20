defmodule JsonValue do
  defstruct field_a: "", field_b: "", field_c: "", field_g: "", field_list: []

  def parse(json_text) do
    populate_struct(JSON.decode(json_text))
  end

  defp populate_struct({:ok, json_data}) do
    %JsonValue{
      field_a:    parse_field(json_data, ["a"]),
      field_b:    parse_field(json_data, ["b"]),
      field_g:    parse_field(json_data, ["f", "g"]),
      field_list: parse_field(json_data, ["c"])
    }
  end

  defp populate_struct({:error, message}) do
    "BAD DATA: #{message}"
  end

  defp parse_field(json_value, []), do: json_value
  defp parse_field(json_data, [name | more_names]) do
    case Map.has_key?(json_data, name) do
      true ->  parse_field(json_data[name], more_names)
      false -> "MISSING #{name}"
    end
  end
end

