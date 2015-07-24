defmodule SheetLoader.Worker do
  require Logger
  use GenServer

  @default_poll_delay 5 * 60
  @default_dir "."

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
        # For now we only support one spreadsheet
        [config] = Application.get_env :google_sheets, :spreadsheets, []

        spreadsheet_config_id = Keyword.fetch! config, :id
        poll_delay_seconds    = Keyword.get(config, :poll_delay_seconds, @default_poll_delay)
        dir                   = Keyword.get(config, :dir, @default_dir)

        version_key = GoogleSheets.latest_key! spreadsheet_config_id
        data        = GoogleSheets.fetch! version_key

        Logger.info "Writing yaml to file..."
        File.write! dir <> "/en.yaml", data

        send self, :update # never-ending loop
        :timer.sleep(poll_delay_seconds * 5 * 1000) # This timer needs to always be more than poll_delay_seconds
    end
  end

end
