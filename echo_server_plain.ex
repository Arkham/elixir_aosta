defmodule EchoServer do

  ## Public API
  def start() do
    pid = spawn(__MODULE__, :init, [])
    {:ok, pid}
  end

  def write(pid, message) do
    send pid, {:message, message}
    :ok
  end

  def stop(pid) do
    send pid, :stop
    :ok
  end

  ## Internal callbacks
  def init() do
    IO.puts "I am initializing"
    loop()
  end

  defp loop() do
    receive do
      :stop ->
        terminate()

      {:message, msg} ->
        IO.puts msg
        loop()
    end
  end

  def terminate do
    IO.puts "I am terminating"
  end
end
