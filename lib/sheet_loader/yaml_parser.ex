defmodule SheetLoader.YamlParser do

  @behaviour GoogleSheets.Parser

  def parse(_id, _version, worksheets) do
    map = assemble_yaml_to_sheet_map(worksheets, %{})
    {:ok, map}
  end

  defp assemble_yaml_to_sheet_map([], map), do: map
  defp assemble_yaml_to_sheet_map([%GoogleSheets.WorkSheet{csv: csv, name: name} | rest], map) do
    yaml = assemble_yaml(csv, name)
    map  = Dict.put(map, String.to_atom(name), yaml)
    assemble_yaml_to_sheet_map(rest, map)
  end

  defp assemble_yaml(csv, name) do
    rows                 = String.split csv, "\n"
    rows_as_key_values   = Enum.map rows, fn row -> String.split row, ",", parts: 2 end
    yaml_key_value_lines = extract_key_values rows_as_key_values

    """
    ---
    #{name}:
    #{yaml_key_value_lines}
    """
  end

  defp extract_key_values([]), do: ""
  defp extract_key_values([[""]]), do: ""
  defp extract_key_values([key_value | rest]) do
    [key | [value | _]] = key_value
    "  #{key}: #{value}\n" <> extract_key_values(rest)
  end

end
