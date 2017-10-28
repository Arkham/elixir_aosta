defmodule Test do
  def timeout do
    parent = self()

    spawn(fn ->
      Process.sleep(4_000)
      send parent, "Hey there"
    end)

    receive do
      msg ->
        IO.inspect msg

    after
      5_000 ->
        IO.puts "timed out"
    end
  end

  def test_error do
    # parent = self()
    # Process.flag(:trap_exit, true)

    pid = spawn(fn ->
      # Process.link(parent)
      Process.sleep(4_000)

      # :foo = :bar
      :bar = :bar
      IO.puts "Hi mom"
    end)

    Process.monitor(pid)
  end

  def start do
    spawn(__MODULE__, :loop, [:idle])
  end

  def loop(state) do
    receive do
      :stop ->
        IO.puts "bye"

      {:set_state, new_state} ->
        loop(new_state)

      {:guess, ^state} ->
        IO.puts "You got me"
        loop(state)

      msg ->
        IO.inspect("state = #{state}, msg = #{inspect msg}")
        loop(state)
    end
  end
end
