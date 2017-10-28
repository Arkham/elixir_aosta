defmodule RingChain.Master do
  alias RingChain.Node

  def start(nodes \\ 5)
  when is_integer(nodes) and nodes > 1 do
    {:ok, first} = Node.start(1)

    last =
      2..nodes
      |> Enum.to_list()
      |> List.foldl(first, fn(x, previous) ->
        {:ok, current} = Node.start(x)
        # send previous, {:set_next, current}
        Node.set_next(previous, current)
        current
      end)

    # send last, {:set_next, first}
    Node.set_next(last, first)

    # send first, {:increment, 0}
    Node.increment(first, 0)

    {:ok, first}
  end

  def stop(pid) do
    # send pid, :stop
    Node.stop(pid)
  end
end
