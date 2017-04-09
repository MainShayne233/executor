defmodule Executor.Node do
  alias Executor.{Shared, Util}

  @moduledoc """
  This module is responsible for executing node code.
  """

  @doc """
  Returns the result map for the given Node code

    iex> run("console.log('i kind of like that it does this'); 1 / 0")
    {:ok, %{return: "Infinity", stdout: "i kind of like that it does this"}}
  """

  def run(code) do
    Shared.run(
      code |> Util.String.semicolonize,
      "node"
    )
  end

  @doc """
  Returns Node specific name for temporary script file
  """

  def new_file_name, do: "./exe/node_run_#{:os.system_time}.js"

  @doc """
  Generates the script to execute Node code.
  Code is rescued on error
  Deliminators are placed in to aid in capturing results
  """

  def code_template(code) do
    """
    try {
      return_value = eval("#{code}")
      process.stdout.write("#{Shared.stdout_terminated_indicator()}")
      process.stdout.write("#{Shared.return_indicator()}")
      console.log(return_value)
      process.stdout.write("#{Shared.return_indicator()}")
    } catch(e) {
      process.stdout.write("#{Shared.error_type_indicator()}")
      process.stdout.write(e.name)
      process.stdout.write("#{Shared.error_type_indicator()}")
      process.stdout.write("#{Shared.error_message_indicator()}")
      process.stdout.write(e.message)
      process.stdout.write("#{Shared.error_message_indicator()}")
    }
    """
  end
end
