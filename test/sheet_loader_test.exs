defmodule SheetLoaderTest do
  use ExUnit.Case

  test "YAML parsing from CSV" do
    csv = """
    title,SimpleSite v0.1
    x,y
    """
    name = "en"

    {:ok, yaml} = SheetLoader.YamlParser.parse(0, 0, [%GoogleSheets.WorkSheet{csv: csv, name: name}])

    assert yaml == """
    ---
    en:
    - title: SimpleSite v0.1
    - x: y

    """
  end

end
