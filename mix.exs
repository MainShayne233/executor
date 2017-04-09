defmodule Executor.Mixfile do
  use Mix.Project

  def project do
    [app: :executor,
     version: "0.0.1",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp description do
    """
    Allows for code execution in Elixir.
    """
  end

  defp package do
    [
      licences: ["MIT"],
      maintainers: ["MainShayne233"],
      links: %{github: "https://github.com/MainShayne233/executor"},
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.7", only: [:dev, :test]},
      {:dogma,  "~> 0.1", only: :dev},
    ]
  end
end
