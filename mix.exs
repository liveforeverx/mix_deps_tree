defmodule MixDepsTree.Mixfile do
  use Mix.Project

  def project do
    [app: :mix_deps_tree,
     version: "0.1.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     description: description,
     package: package]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    []
  end

  defp description do
    "Mix task to print dependency tree of an application to a terminal"
  end

  defp package do
    [maintainers: ["Dmitry Russ(Aleksandrov)"],
     links: %{"Github" => "https://github.com/liveforeverx/mix_deps_tree"}]
  end
end
