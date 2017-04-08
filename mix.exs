defmodule Executor.Mixfile do
  use Mix.Project

  def project do
    [app: :executor,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:maru,  "~> 0.11.4"},
      {:credo, "~> 0.7", only: [:dev, :test]},
    ]
  end
end
