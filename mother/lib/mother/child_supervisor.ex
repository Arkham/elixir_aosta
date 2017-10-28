defmodule Mother.ChildSupervisor do
  use Supervisor

  def start_link(_) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Mother.Worker.start_link(arg)
      # {Mother.Worker, arg},
      Supervisor.child_spec({Mother.Child, "Slim Shady"}, id: :slim),
      Supervisor.child_spec({Mother.Child, "Dr Dre"}, id: :dre),
      Supervisor.child_spec({Mother.Child, "S N O O P DOUBLE G"}, id: :snoop)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_all, name: Mother.ChildSupervisor]
    Supervisor.start_link(children, opts)
  end
end
