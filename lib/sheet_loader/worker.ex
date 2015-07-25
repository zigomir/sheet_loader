defmodule SheetLoader.Worker do
  require Logger
  use GenServer

  @default_poll_delay 5 * 60
  @default_dir "."
  @default_sheet "en"

  # require IEx
  # IEx.pry
  def start_link do
    {:ok, pid} = Task.start_link(fn -> loop() end)
    send pid, :update
    {:ok, pid}
  end

  defp loop do
    receive do
      :update ->
        configs = Application.get_env :google_sheets, :spreadsheets, []
        poll_delay_seconds = save_yaml_file_for_sheet(configs) # it will only take poll_delay_seconds from last config

        send self, :update # never-ending loop
        :timer.sleep(poll_delay_seconds * 2 * 1000) # This timer needs to always be more than poll_delay_seconds
    end
  end

  defp save_yaml_file_for_sheet([]), do: nil
  defp save_yaml_file_for_sheet([config | rest]) do
    spreadsheet_config_id = Keyword.fetch! config, :id
    poll_delay_seconds    = Keyword.get(config, :poll_delay_seconds, @default_poll_delay)
    dir                   = Keyword.get(config, :dir, @default_dir)
    [sheet]               = Keyword.get(config, :sheets, @default_sheet) # Assumption: only one sheet per spreadsheet config

    {version_key, data} = GoogleSheets.latest! spreadsheet_config_id
    file                = "#{dir}/#{sheet}.yml"

    Logger.info "Writing #{file} file..."
    File.write! file, data

    save_yaml_file_for_sheet(rest)
    poll_delay_seconds
  end

end
