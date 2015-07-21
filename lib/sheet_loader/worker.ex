defmodule SheetLoader.Worker do
  use GenServer

  ## Client API

  def start_link(_arg) do
    IO.puts "STARTING WORKER!"
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def load_sheet(server) do
    GenServer.call(server)
  end


  ## Server Callbacks

  def handle_call() do
    # GoogleSheets.latest :my_sheet

    :timer.sleep(2000)
    GoogleSheets.latest :my_sheet
    IO.puts "RANDA!"
    # result = ElixirPoolboyExample.Squarer.square(data)
    # IO.puts "Worker Reports: #{data} * #{data} = #{result}"

    {:reply, ""} # handle call needs to return :reply
  end

end
