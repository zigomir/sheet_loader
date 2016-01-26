defmodule SheetLoaderTest do
  use ExUnit.Case

  test "YAML parsing from CSV" do
    csv = """
    title,SimpleSite v0.1
    x,y
    """

    {:ok, %{en: yaml}} = SheetLoader.YamlParser.parse(0, [%GoogleSheets.WorkSheet{csv: csv, name: "en"}])

    assert yaml == """
    ---
    en:
      title: SimpleSite v0.1
      x: y

    """
  end

end
