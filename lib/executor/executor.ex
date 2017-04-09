defmodule Executor do
  alias Executor.Util

  @moduledoc """
  This module is responsible for routing code to the appropriate language module
  """

  @doc """
  Returns result map for given language and code

    iex> run("[1,2,3].map {|i| 2 * i}", "ruby")
    {:ok, %{return: "[2, 4, 6]", stdout: ""}}
  """

  def run(code, language) do
    with {:ok, language_module} <- module_for(language) do
      code
      |> language_module.run
    end
  end

  @doc """
  Returns module for language if one exists, error otherwise

    iex> module_for("ruby")
    {:ok, Elixir.Executor.Ruby}

    iex> module_for("java")
    {:error, "Can't run java code"}
  """

  def module_for(language) do
    module = [
      "Elixir.Executor.",
      language |> Util.String.titleize,
    ]
    |> Enum.join
    |> String.to_existing_atom
    {:ok, module}
  rescue
    _ -> {:error, "Can't run #{language} code"}
  end

end
