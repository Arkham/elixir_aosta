defmodule Mother.Child do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, name)
  end

  def hi(pid) do
    GenServer.cast(pid, :hi)
  end

  def init(name) do
    {:ok, name}
  end

  def handle_cast(:hi, name) do
    IO.puts "Hi! My name is #{name}"
    {:noreply, name}
  end
end
