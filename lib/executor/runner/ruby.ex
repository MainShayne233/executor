defmodule Executor.Runner.Ruby do

  @moduledoc """
  This module is responsible for executing ruby code.
  The response should be identical to that of irb, where
  print/put statements are returned, and the actual return value
  is preceaded by '=>'
  """

  def run(code) do
    file_name = create_file(code)
    "ruby"
    |> System.cmd([file_name])
    |> case do
      {result, 0} ->
        File.rm(file_name)
        {:ok, result}
      {_, 1} ->
        File.rm(file_name)
        {:error, "Error when executing code"}
    end
  end

  def create_file(code) do
    file_name = new_file_name()
    file_name
    |> File.write!(code |> sanitize_code |> code_template)
    file_name
  end

  def new_file_name, do: "./exe/ruby_run_#{:os.system_time}.rb"

  def sanitize_code(code) do
    code = code
    |> String.replace(~s("), ~s(\\"))
    ~r/\#{(.*?)}/
    |> Regex.replace(code, "\#{\\1}")
    |> String.replace(~s(\#{), ~s(\\\#{))
  end

  def code_template(code) do
    """
    begin
      return_val = eval "\n#{code}\n"
      print "=> \#{return_val || 'nil'}"
    rescue Exception => e
      print e.class
      print ': '
      print e.message
    end
    """
  end
end
