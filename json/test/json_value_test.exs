defmodule JsonValueTest do
  use ExUnit.Case

  @json_data ~s(
    {
      "a": "1",
      "b": "2",
      "c": [
        "d",
        "e"
      ],
      "f": {
        "g": "3"
      }
    }
  )

  test "json values" do
    json_value = JsonValue.parse(@json_data)
    assert "1" == json_value.field_a
    assert "2" == json_value.field_b
    assert "3" == json_value.field_g

    assert ["d","e"] == json_value.field_list
  end

  test "missing values" do
    assert "MISSING b" == JsonValue.parse(~s({"a": "1"})).field_b
  end

  test "some bad json" do
    assert "BAD DATA: unexpected_end_of_buffer" == JsonValue.parse("")
  end
end

