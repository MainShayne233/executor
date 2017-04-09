defmodule Executor.Elixir do
  alias Executor.Shared

  @moduledoc """
  This module is responsible for executing elixir code.
  """

  def run(code) do
    with {:ok, result} <- Shared.run("elixir", code) do
      {
        :ok,
        result,
      }
    end
  end

  def new_file_name, do: "./exe/elixir_run_#{:os.system_time}.exs"

  def code_template(code) do
    """
    try do
      return_val = Code.eval_string("#{code}")
      IO.puts "#{Shared.std_out_terminated_indicator()}"
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
