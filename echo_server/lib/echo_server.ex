defmodule EchoServer do
  @moduledoc """
  Documentation for EchoServer.
  """
  use Application

  def start(_, _) do
    EchoServer.Server.start()
  end
end
