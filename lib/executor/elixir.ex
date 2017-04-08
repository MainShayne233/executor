defmodule Executor.Elixir do
  alias Executor.{Shared, Util}

  @moduledoc """
  This module is responsible for executing elixir code.
  The response should be identical to that of IEx, where
  IO.inspect/IO.puts statements are returned, and the actual return value
  is the last value
  """

  def run(code) do
    with {:ok, result} <- Shared.run("elixir", code) do
      {
        :ok,
        result
        |> Util.String.remove_trailing_new_line,
      }
    end
  end

  def new_file_name, do: "./exe/elixir_run_#{:os.system_time}.exs"

  def code_template(code) do
    """
    try do
      return_val = Code.eval_string("#{code}")
      IO.inspect return_val |> elem(0)
      rescue
      e ->
        message = Map.get(e, :message) || Map.get(e, :description) || ""
        IO.puts "** (" <> inspect(e.__struct__) <> ") " <> message
    end
    """
  end
end
