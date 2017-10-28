defmodule MotherTest do
  use ExUnit.Case
  doctest Mother

  test "greets the world" do
    assert Mother.hello() == :world
  end
end
