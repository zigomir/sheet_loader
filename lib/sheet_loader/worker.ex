require IEx

defmodule SheetLoader.Worker do
  require Logger
  use GenServer

  @default_poll_delay 5 * 60
  @default_dir "."
  @default_post_save_command nil

  def start_link do
    {:ok, pid} = Task.start_link(fn -> loop() end)
    send pid, :update
    {:ok, pid}
  end

  defp loop do
    receive do
      :update ->
        # configs = Application.get_env :google_sheets, :spreadsheets, []
        {:ok, configs} = Application.fetch_env :google_sheets, :spreadsheets
        config = save_yaml_file_for_sheet(configs) # it will only take poll_delay_seconds from last config

        poll_delay_seconds = Keyword.get(config, :poll_delay_seconds, @default_poll_delay)
        # post_save          = Keyword.get(config, :post_save, @default_post_save_command)
        #
        # if post_save do
        #   Task.start_link(fn ->
        #     { command_result, _code } = System.cmd(post_save[:command], post_save[:args], cd: post_save[:directory])
        #     Logger.info "Command result = #{command_result}."
        #   end)
        # end

        send self, :update # never-ending loop
        :timer.sleep(poll_delay_seconds * 2 * 1000) # This timer needs to always be more than poll_delay_seconds
    end
  end

  defp save_yaml_file_for_sheet([]), do: nil
  defp save_yaml_file_for_sheet([{_id, config} | rest]) do
    dir = Keyword.get(config, :dir, @default_dir)

    { _version_key, worksheets_as_yaml } = GoogleSheets.latest! :config

    Enum.map Map.keys(worksheets_as_yaml), fn worksheet_tab ->
      file_path = "#{dir}/#{worksheet_tab}.yml"
      Logger.info "Writing #{file_path} file..."
      File.write! file_path, Map.get(worksheets_as_yaml, worksheet_tab)
    end

    save_yaml_file_for_sheet(rest)
    config
  end

end
