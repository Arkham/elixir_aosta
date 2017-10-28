defmodule RingChain.Node do
  def start(id) do
    pid = spawn(__MODULE__, :init, [id])
    {:ok, pid}
  end

  def init(id) do
    loop({id})
  end

  def loop({id}) do
    receive do
      {:set_next, next} ->
        loop({id, next})
    end
  end
  def loop({id, next} = state) do
    receive do
      {:increment, count} ->
        cond do
          id == 1 && rem(count, 10_000) == 0 ->
            IO.puts "#{id}: received #{inspect count}"
          true ->
            :noop
        end

        send next, {:increment, count + 1}
        loop(state)

      :stop ->
        send next, :stop
    end
  end
end
