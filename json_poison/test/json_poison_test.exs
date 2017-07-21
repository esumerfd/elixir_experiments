defmodule JsonPoisonTest do
  use ExUnit.Case

  @json_data ~s(
    {
      "field_a": "1",
      "field_b": "2",
      "field_c": [
        "d",
        "e"
      ],
      "field_f": {
        "field_g": "3"
      }
    }
  )

  test "json values" do
    json_value = JsonPoison.parse(@json_data)

    assert "1" == json_value.field_a
    assert "2" == json_value.field_b
    assert "3" == json_value.field_f.field_g

    assert ["d","e"] == json_value.field_c
  end

  test "some bad json" do
    assert "BAD DATA: invalid" == JsonPoison.parse("")
  end

  test "encoding json" do
    assert ~s({"field_f":{"field_g":"yes"},"field_c":[1,2],"field_b":"2","field_a":"1"}) ==
      JsonPoison.format(%{field_a: "1", field_b: "2", field_c: [1,2], field_f: %{field_g: "yes"}})
  end
end
