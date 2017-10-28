defmodule RingChain.Node do
  use GenServer

  # Public API

  def start(id) do
    # pid = spawn(__MODULE__, :init, [id])
    # {:ok, pid}
    GenServer.start(__MODULE__, id)
  end

  def set_next(pid, next) do
    GenServer.cast(pid, {:set_next, next})
  end

  def increment(pid, count) do
    GenServer.cast(pid, {:increment, count})
  end

  def stop(pid) do
    GenServer.cast(pid, :stop)
  end

  # Internal callbacks

  def init(id) do
    # loop({id})
    {:ok, {id}}
  end

  # def loop({id}) do
  #   receive do
  #     {:set_next, next} ->
  #       loop({id, next})
  #   end
  # end
  def handle_cast({:set_next, next}, {id}) do
    {:noreply, {id, next}}
  end

    # Esempio concettuale
    # def loop(state) do
    #   receive do
    #     msg ->
    #       {:noreply, new_state} = handle_cast(msg, state)
    #       loop(new_state)

  # def loop({id, next} = state) do
  #   receive do
  #     {:increment, count} ->
  #       cond do
  #         id == 1 && rem(count, 10_000) == 0 ->
  #           IO.puts "#{id}: received #{inspect count}"
  #         true ->
  #           :noop
  #       end

  #       send next, {:increment, count + 1}
  #       loop(state)

  #     :stop ->
  #       send next, :stop
  #   end
  # end
  def handle_cast({:increment, count}, {id, next} = state) do
    cond do
      id == 1 && rem(count, 10_000) == 0 ->
        IO.puts "#{id}: received #{inspect count}"
      true ->
        :noop
    end

    increment(next, count + 1)

    {:noreply, state}
  end
  def handle_cast(:stop, {_id, next} = state) do
    stop(next)
    {:stop, :normal, state}
  end
end
