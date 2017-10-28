defmodule PingPong do
  def start do
    ping = spawn(__MODULE__, :player, [:ping, 5])
    pong = spawn(__MODULE__, :player, [:pong, 7])

    send ping, :start

    send ping, {:set_opponent, pong}
    send pong, {:set_opponent, ping}
  end

  def player(name, charges) do
    player_loop({name, charges})
  end

  def player_loop({name, charges}) do
    receive do
      {:set_opponent, opponent} ->
        Process.monitor(opponent)
        player_loop({name, charges, opponent})
    end
  end
  def player_loop({_name, 0, _opponent}) do
    IO.puts "#{inspect self()}: No more charges :("
  end
  def player_loop({name, charges, opponent}) do
    receive do
      :stop ->
        IO.puts "#{inspect self()}: Bye"

      {:DOWN, _, _, ^opponent, _} ->
        IO.puts "#{inspect self()}: My opponent is down, bye"

      msg ->
        IO.puts "#{inspect self()}: Received #{inspect msg}"
        Process.sleep 2_000

        send opponent, name
        player_loop({name, charges - 1, opponent})
    end
  end
end
