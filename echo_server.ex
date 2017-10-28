defmodule EchoServer do
  use GenServer

  ## Public API
  def start() do
    GenServer.start(__MODULE__, [])
  end

  def write(pid, message) do
    GenServer.cast(pid, {:message, message})
  end

  def status(pid) do
    GenServer.call(pid, :status)
  end

  def stop(pid) do
    GenServer.stop(pid)
  end

  ## Internal callbacks
  def init([]) do
    IO.puts "I am initializing"
    {:ok, :empty}
  end

  def handle_cast({:message, message}, state) do
    IO.puts "start"
    IO.puts message
    IO.puts "end"
    IO.puts ""
    {:noreply, state}
  end

  def handle_call(:status, from, state) do
    Process.sleep 2_000
    {
      :reply,
      "hi mom, I'm all good, from is #{inspect from}",
      state
    }
  end

  def terminate(_reason, _state) do
    IO.puts "I am terminating"
  end
end
