defmodule Executor.Ruby do
  alias Executor.Shared

  @moduledoc """
  This module is responsible for executing ruby code.
  """

  @doc """
  Returns result map for the given code

    iex> run("puts 'ayyy'; 2**3")
    {:ok, %{return: "8", stdout: "ayyy"}}
  """

  def run(code), do: Shared.run(code, "ruby")

  @doc """
  Returns Ruby specific file name for temporary script
  """

  def new_file_name, do: "ruby_run_#{:os.system_time}.rb"

  @doc """
  Generates the script to execute Ruby code.
  Code is rescued on error
  Deliminators are placed in to aid in capturing results
  """

  def code_template(code) do
    """
    begin
      return_val = eval "\n#{code}\n"
      puts "#{Shared.stdout_terminated_indicator()}"
      print "#{Shared.return_indicator()}"
      print "\#{return_val || 'nil'}"
      print "#{Shared.return_indicator()}"
    rescue Exception => e
      print "#{Shared.error_type_indicator}"
      print "\#{e.class}"
      print "#{Shared.error_type_indicator}"
      print "#{Shared.error_message_indicator}"
      print "\#{e.message}"
      print "#{Shared.error_message_indicator}"
    end
    """
  end
end
