defmodule Executor.Runner.Node do
  alias Executor.Runner.Shared

  @moduledoc """
  This module is responsible for executing node code.
  The response should be identical to that of the node repl/cli, where
  console.log() return, and the return value is the final value
  """

  def run(code) do
    with {:ok, result} <- Shared.run("node", sanitize(code)) do
      {:ok, result |> remove_new_line}
    end
  end

  def sanitize(code) do
    code
    |> String.split("\n")
    |> Enum.join(";")
  end

  def new_file_name, do: "./exe/node_run_#{:os.system_time}.js"

  def code_template(code) do
    """
    try {
      return_value = eval("#{code}")
      console.log(return_value)
    } catch(e) {
      console.log(e.name + ': ' + e.message)
    }
    """
  end

  def remove_new_line(result) do
    result
    |> String.reverse
    |> String.codepoints
    |> List.first
    |> case do
      "\n" -> result |> String.slice(0..-2)
      _    -> result
    end
  end
end
