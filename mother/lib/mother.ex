defmodule Mother do
  @moduledoc """
  Documentation for Mother.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Mother.hello
      :world

  """
  def hello do
    :world
  end

  def crash do
    1..30
    |> Enum.each(fn x ->
      case Process.whereis(Mother.ChildSupervisor) do
        nil ->
          :noop

        value ->
          IO.puts inspect(value)

          {_, pid, _, _} =
            value
            |> Supervisor.which_children()
            |> List.first

          Process.exit(pid, :kill)
      end
    end)
  end
end
