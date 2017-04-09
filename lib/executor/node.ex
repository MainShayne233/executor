defmodule Executor.Node do
  alias Executor.Shared

  @moduledoc """
  This module is responsible for executing node code.
  """

  def run(code) do
    with {:ok, result} <- Shared.run("node", sanitize(code)) do
      {
        :ok,
        result
      }
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
