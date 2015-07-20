defmodule SheetLoader.YamlParser do
  require Logger
  @behaviour GoogleSheets.Parser

  # TODO: this is not the best way to save it to a file :)
  # require IEx
  # IEx.pry
  def parse(_id, _version, worksheets) do
    yaml = assemble_yaml(worksheets)


    Logger.info "Writing yaml to file..."
    File.write! "priv/data/en.yaml", yaml

    {:ok, worksheets}
  end

  defp assemble_yaml([%GoogleSheets.WorkSheet{csv: csv, name: name}]) do
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
  defp extract_key_values([key_value | rest]) do
    [key | [value | _]] = key_value
    "- #{key}: #{value}\n" <> extract_key_values(rest)
  end

end
