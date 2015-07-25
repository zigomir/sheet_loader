defmodule SheetLoader.YamlParser do

  @behaviour GoogleSheets.Parser

  def parse(_id, _version, worksheets) do
    yaml = assemble_yaml(worksheets)
    {:ok, yaml}
  end

  defp assemble_yaml([]), do: ""
  defp assemble_yaml([%GoogleSheets.WorkSheet{csv: csv, name: name} | rest]) do
    rows                 = String.split csv, "\n"
    rows_as_key_values   = Enum.map rows, fn row -> String.split row, ",", parts: 2 end
    yaml_key_value_lines = extract_key_values rows_as_key_values

    """
    ---
    #{name}:
    #{yaml_key_value_lines}
    """ <> assemble_yaml(rest)
  end

  defp extract_key_values([]), do: ""
  defp extract_key_values([[""]]), do: ""
  defp extract_key_values([key_value | rest]) do
    [key | [value | _]] = key_value
    "  #{key}: #{value}\n" <> extract_key_values(rest)
  end

end
