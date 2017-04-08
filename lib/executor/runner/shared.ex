defmodule Executor.Runner.Shared do
  alias Executor.Runner

  @moduledoc """
  This contains shared execution code that is 
  valid for numerous languages
  """

  def run(language, code) do
    file_name = create_file(language, code)
    language
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

  def create_file(language, code) do
    language_module = language
    |> Runner.module_for
    |> elem(1)
    file_name = language_module.new_file_name()
    file_name
    |> File.write!(
      code 
      |> sanitize_code 
      |> language_module.code_template
    )
    file_name
  end

  def sanitize_code(code) do
    code = code
    |> String.replace(~s("), ~s(\\"))
    ~r/\#{(.*?)}/
    |> Regex.replace(code, "\#{\\1}")
    |> String.replace(~s(\#{), ~s(\\\#{))
  end


end
