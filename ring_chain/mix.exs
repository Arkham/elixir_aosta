defmodule RingChain.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ring_chain,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(Mix.env)
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps(:test) do
    shared_deps() ++ []
  end
  defp deps(:dev) do
    shared_deps() ++ [
      {:ex_doc, "~> 0.16", runtime: false}
    ]
  end
  defp shared_deps do
    [
      # {:postgrex, "~> 0.13.3"}
      # {:new_relic, git: "https://github.com/Arkham/newrelic.ex.git", branch: "master"}
      # {:cowboy, "~> 2.0.0"}
    ]
  end
end
