defmodule Executor.Runner do
  alias Executor.Utils

  def run(%{language: language, code: code}) do
    with {:ok, language_module} <- module_for(language) do
      code
      |> language_module.run
    end
  end

  def module_for(language) do
    try do
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

end
