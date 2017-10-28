defmodule RingChainTest do
  use ExUnit.Case
  doctest RingChain

  test "calculates the fibonacci numbers" do
    assert RingChain.fibonacci(1) == 1
    assert RingChain.fibonacci(2) == 1
    assert RingChain.fibonacci(3) == 2
    assert RingChain.fibonacci(4) == 3
    assert RingChain.fibonacci(5) == 5
    assert RingChain.fibonacci(6) == 8
  end

  defmodule TestNode do
    def start(id) do
      Agent.start_link(fn -> {} end)
    end

    def set_next(pid, next) do
      # IO.puts "set_next #{inspect pid}, #{inspect next}"
      Agent.update(pid, fn _state -> {next} end)
    end

    def get_next(pid) do
      Agent.get(pid, fn {next} -> next end)
    end

    def increment(pid, count) do
      send self(), {:increment, pid, 0}
    end

    def stop(pid) do
    end
  end

  test "it creates a ring" do
    {:ok, first} = RingChain.start(5, TestNode)

    result =
      1..5
      |> Enum.to_list()
      |> List.foldl(first, fn num, previous ->
        next = TestNode.get_next(previous)
        assert next != previous
        next
      end)

    assert result == first
  end

  test "it starts the chain with one message" do
    {:ok, first} = RingChain.start(5, TestNode)
    assert_receive {:increment, first, 0}
  end
end
