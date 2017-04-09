defmodule Executor.Elixir do
  alias Executor.Shared

  @moduledoc """
  This module is responsible for executing elixir code.
  """

  @doc """
  Returns result map for the given Elixir code

    iex> run("%{not: :me} |> Map.get_lazy(:but, fn -> :this end)")
    {:ok, %{return: ":this", stdout: ""}}
  """

  def run(code), do: Shared.run(code, "elixir")

  @doc """
  Returns Elixir specific file name for temporary script
  """

  def new_file_name, do: "elixir_run_#{:os.system_time}.exs"

  @doc """
  Generates the script to execute Elixir code.
  Code is rescued on error
  Deliminators are placed in to aid in capturing results
  """

  def code_template(code) do
    """
    try do
      return_val = Code.eval_string("#{code}")
      IO.puts "#{Shared.stdout_terminated_indicator()}"
      IO.puts "#{Shared.return_indicator()}"
      IO.inspect return_val |> elem(0)
      IO.puts "#{Shared.return_indicator()}"
    rescue
      e ->
        message = Map.get(e, :message) || Map.get(e, :description) || ""
        IO.puts "#{Shared.error_type_indicator()}"
        IO.puts "\#{inspect e.__struct__}"
        IO.puts "#{Shared.error_type_indicator()}"
        IO.puts "#{Shared.error_message_indicator()}"
        IO.puts message
        IO.puts "#{Shared.error_message_indicator()}"
    end
    """
  end
end
