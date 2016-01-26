defmodule SheetLoader.YamlParser do

  @behaviour GoogleSheets.Parser

  def parse(_id, worksheets) do
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

    if String.contains?(value, "[") and String.contains?(value, "]") do
      list_values = value
        |> String.replace("\"", "") # TODO: what about when we want to have " in content
        |> String.replace("[", "")
        |> String.replace("]", "")
        |> String.split(",")
        |> Enum.map(fn(v) -> String.strip(v) end)
        |> Enum.join("\n    - ")

      """
        #{key}:
          - #{list_values}
      """ <> extract_key_values(rest)
    else
      "  #{key}: #{value}\n" <> extract_key_values(rest)
    end
  end

end
