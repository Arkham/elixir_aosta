defmodule RingChain do
  @moduledoc """
  Documentation for RingChain.
  """

  alias RingChain.{Master,Node}

  @doc """
  Starts a new chain composed of n rings
  and returns `{:ok, first_ring_pid}`.
  """
  def start(nodes \\ 5, node_module \\ Node) do
    Master.start(nodes, node_module)
  end

  @doc """
  Stops a given ring of the chain and
  subsequently stop the whole chain.
  """
  def stop(pid) do
    Node.stop(pid)
  end

  def fibonacci(1), do: 1
  def fibonacci(2), do: 1
  def fibonacci(n) when n > 0 do
    fibonacci(n - 1) + fibonacci(n - 2)
  end
end
