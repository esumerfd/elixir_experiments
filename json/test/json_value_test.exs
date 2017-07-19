defmodule JsonValueTest do
  use ExUnit.Case

  # Parse this JSON string

  @json_data ~s(
    {
      "a": "1", "b": "2",
      "c": [
        "d",
        "e"
      ],
      "f": {
        "g": "h"
      }
    }
  )

  test "json values" do
    assert "1" == JsonValue.parse(@json_data) |> JsonValue.value_a
    assert "2" == JsonValue.parse(@json_data) |> JsonValue.value_b
    assert "h" == JsonValue.parse(@json_data) |> JsonValue.value_g

    assert ["d","e"] == JsonValue.parse(@json_data) |> JsonValue.value_list
  end
end