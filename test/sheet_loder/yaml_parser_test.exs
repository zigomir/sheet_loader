defmodule SheetLoader.YamlParserTest do
  use ExUnit.Case

  test "Parse CSV to YAML" do
    csv = """
    description,ready when you are
    x,y
    people,[mirko, radirko, zobar]
    keys,\"[x, y, z]\"
    wadap,that's cool
    """

    {:ok, %{en: yaml}} = SheetLoader.YamlParser.parse(0, [%GoogleSheets.WorkSheet{csv: csv, name: "en"}])

    assert yaml == """
    ---
    en:
      description: ready when you are
      x: y
      people:
        - mirko
        - radirko
        - zobar
      keys:
        - x
        - y
        - z
      wadap: that's cool

    """
  end

end
