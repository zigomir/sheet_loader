defmodule SheetLoader.Worker do
  use GenServer

  def start_link do
    {:ok, pid} = Task.start_link(fn -> loop() end)
    send pid, {:update}
    IO.puts "kokoko"
    {:ok, pid}
  end

  defp loop do
    receive do
      {:update} ->

        # {:ok, version_key, data} = GoogleSheets.latest :my_sheet
        # IO.puts "YAY"
        # IO.puts version_key
        # IO.inspect data
        # {:ok, version_key} = GoogleSheets.latest_key :my_sheet
        version_key = GoogleSheets.latest_key! :my_sheet

        # With a previously queried version_key
        # {:ok, data} = GoogleSheets.fetch version_key
        data = GoogleSheets.fetch! version_key
        IO.inspect data

        IO.puts "kokoko ooooooooooooooooo"
        send self, {:update} # neverneding loop, waw
        :timer.sleep(2000)
      # {:get, key, caller} ->
      #   send caller, Map.get(map, key)
      #   loop(map)
      # {:put, key, value} ->
      #   loop(Map.put(map, key, value))
    end
  end

  ## Client API

#   def start_link(opts \\ []) do
#     server = GenServer.start_link(__MODULE__, [], name: __MODULE__)
#     # load_sheet(server)
#
#     # Process.send_after(self, :update, delay_seconds * 1000)
#   end
#
#   def load_sheet({:ok, server}) do
#     GenServer.call(server, {:poll, server})
#   end
#
# #   @zigomir: You need to have a loop which executes the polling task
# #
# # iwarshak [12:43 AM]
# # @zigomir: I have a gen server that, when started, starts a task which sleeps for 60 seconds, runs the poller, then calls itself
#
#   ## Server Callbacks
#   # OMG WE NEED ALL PARAMS
#   def handle_call({:poll, server}, _from, _state) do
#     # GoogleSheets.latest :my_sheet
#
#     :timer.sleep(2000)
#     {:ok, version_key, data} = GoogleSheets.latest :my_sheet
#     IO.puts "RANDA!"
#     IO.puts version_key
#     IO.inspect data
#
#     GenServer.call(server, {:poll, server})
#     # result = ElixirPoolboyExample.Squarer.square(data)
#     # IO.puts "Worker Reports: #{data} * #{data} = #{result}"
#
#     # {:reply, ""} # handle call needs to return :reply
#
#     {:reply, version_key, data} #
#   end

end
