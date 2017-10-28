defmodule RingChain.Master do
  alias RingChain.Node

  def start(nodes \\ 5, node_module \\ Node)
  when is_integer(nodes) and nodes > 1 do
    {:ok, first} = node_module.start(1)

    last =
      2..nodes
      |> Enum.to_list()
      |> List.foldl(first, fn(x, previous) ->
        {:ok, current} = node_module.start(x)
        # send previous, {:set_next, current}
        node_module.set_next(previous, current)
        current
      end)

    # send last, {:set_next, first}
    node_module.set_next(last, first)

    # send first, {:increment, 0}
    node_module.increment(first, 0)

    {:ok, first}
  end
end
