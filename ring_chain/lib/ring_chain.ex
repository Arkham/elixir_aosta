defmodule RingChain do
  @moduledoc """
  Documentation for RingChain.
  """

  alias RingChain.{Master,Node}

  @doc """
  Starts a new chain composed of n rings
  and returns `{:ok, first_ring_pid}`.
  """
  def start(nodes) do
    Master.start(nodes)
  end

  @doc """
  Stops a given ring of the chain and
  subsequently stop the whole chain.
  """
  def stop(pid) do
    Node.stop(pid)
  end
end
