require IEx
defmodule SheetLoader.JsonParser do

  @behaviour GoogleSheets.Parser

  def parse(_id, worksheets) do
    map = assemble_json_to_sheet_map(worksheets, %{})
    {:ok, map}
  end

  defp assemble_json_to_sheet_map([], map), do: map
  defp assemble_json_to_sheet_map([%GoogleSheets.WorkSheet{csv: csv, name: name} | rest], map) do
    json = assemble_json(csv, name)
    map  = Dict.put(map, String.to_atom(name), json)
    assemble_json_to_sheet_map(rest, map)
  end

  defp assemble_json(csv, name) do
    rows               = String.split csv, "\n"
    rows_as_key_values = Enum.map rows, fn row -> String.split row, ",", parts: 2 end
    json_key_values    = "{" <> String.replace_trailing(extract_key_values(rows_as_key_values), ",", "") <> "}"
    """
    {"#{name}":#{json_key_values}}
    """
  end

  defp extract_key_values([]), do: []
  defp extract_key_values([[""]]), do: []
  defp extract_key_values([key_value | rest]) do
    [key | [value | _]] = key_value
    ~s("#{key}":"#{value}",#{extract_key_values(rest)})
  end

end
