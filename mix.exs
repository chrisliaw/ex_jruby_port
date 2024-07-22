defmodule ExJrubyPort.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_jruby_port,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:typed_struct, "~> 0.3"},
      {:ap_procman,
       path: "/Users/chris/01.Workspaces/02.Code-Factory/08-Workspace/elixir/08.WS/ap_procman"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
