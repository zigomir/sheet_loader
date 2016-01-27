defmodule SheetLoader.JsonParserTest do
  use ExUnit.Case

  test "Parse CSV to YAML" do
    csv = """
    description,ready when you are
    wadap,that's cool
    """

    # people,[mirko, radirko, zobar]
    # keys,\"[x, y, z]\"

    {:ok, %{en: json}} = SheetLoader.JsonParser.parse(0, [%GoogleSheets.WorkSheet{csv: csv, name: "en"}])

    # ---
    # en:
    #   description: ready when you are
    #   people:
    #     - mirko
    #     - radirko
    #     - zobar
    #   keys:
    #     - x
    #     - y
    #     - z
    #   wadap: that's cool

    assert json == """
    {"en":{"description":"ready when you are","wadap":"that's cool"}}
    """
  end

end
