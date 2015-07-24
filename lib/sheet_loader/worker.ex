defmodule SheetLoader.Worker do
  require Logger
  use GenServer

  # TODO: this is not the best way to save it to a file :)
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
        version_key = GoogleSheets.latest_key! :my_sheet
        data        = GoogleSheets.fetch! version_key

        Logger.info "Writing yaml to file..."
        File.write! "priv/data/en.yaml", data

        send self, :update # never-ending loop
        :timer.sleep(2000)
    end
  end

end
