defmodule Executor.Runner do
  alias Executor.Utils
  @moduledoc """
  This module is responsible for routing code to the appropriate language module
  """

  def run(%{language: language, code: code}) do
    with {:ok, language_module} <- module_for(language) do
      code
      |> language_module.run
    end
  end

  def module_for(language) do
    module = [
      "Elixir.Executor.Runner.",
      language |> Utils.String.titleize,
    ]
    |> Enum.join
    |> String.to_existing_atom
    {:ok, module}
  rescue
    _ -> {:error, "Can't run #{language} code"}
  end

end
