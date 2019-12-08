defmodule SheetLoader.YamlParserTest do
  use ExUnit.Case

  test "Parse CSV to YAML key values" do
    csv = """
    title,SimpleSite v0.1
    x,y
    """

    {:ok, %{en: yaml}} =
      SheetLoader.YamlParser.parse(0, [%GoogleSheets.WorkSheet{csv: csv, name: "en"}])

    assert yaml == """
           ---
           en:
             title: SimpleSite v0.1
             x: y

           """
  end

  test "Parse CSV to YAML lists" do
    csv = """
    description,ready when you are
    people,[mirko, radirko, zobar]
    keys,\"[x, y, z]\"
    wadap,that's cool
    """

    {:ok, %{en: yaml}} =
      SheetLoader.YamlParser.parse(0, [%GoogleSheets.WorkSheet{csv: csv, name: "en"}])

    assert yaml == """
           ---
           en:
             description: ready when you are
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
