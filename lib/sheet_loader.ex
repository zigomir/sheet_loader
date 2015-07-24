defmodule SheetLoader do
  # use Application

  # # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      worker(SheetLoader.Worker, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SheetLoader.Supervisor]
    Supervisor.start_link(children, opts)
  

    # {:ok, version_key, _data} = GoogleSheets.latest :my_sheet
    # IO.puts version_key
    #
    # Process.send_after(self, :update, 1 * 1000)
    # # GoogleSheets.Updater
    # # {:ok, "yolo"}
  end

  # def start_link do
  #   Task.start_link(fn -> loop() end)
  # end
  #
  # defp loop do
  #   receive do
  #     {:get, key, caller} ->
  #       {:ok, _version_key, _data} = GoogleSheets.latest :my_sheet
  #       loop() # neverneding loop, waw
  #     # {:get, key, caller} ->
  #     #   send caller, Map.get(map, key)
  #     #   loop(map)
  #     # {:put, key, value} ->
  #     #   loop(Map.put(map, key, value))
  #   end
  # end

end
