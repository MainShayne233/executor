defmodule Executor.Shared do
  alias Executor.Util

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
        parse_result(result)
      {_, 1} ->
        File.rm(file_name)
        {:error, "Error when executing code"}
    end
  end

  def parse_result(result) do
    {stdout, rest} = result
    |> parse_stdout
    [
      {:return, return_indicator()},
      {:error_type, error_type_indicator()},
      {:error_message, error_message_indicator()},
    ]
    |> Enum.map(fn {key, delimiter} ->
      {
        key,
        delimiter
        |> Util.String.match_between(rest)
      }
    end)
    |> Enum.into(%{})
    |> Map.put(
      :stdout,
      stdout
    )
    |> case do
      result = %{error_type: nil, error_message: nil} ->
        {:ok, result |> Map.drop([:error_type, :error_message])}
      result ->
        {:error, result}
    end
  end

  def parse_stdout(result) do
    result
    |> String.split(std_out_terminated_indicator())
    |> case do
      [stdout, rest] ->
      {
        stdout
        |> Util.String.remove_trailing_new_line,
        rest,
      }
      [rest] -> {"", rest}
    end
  end

  def create_file(language, code) do
    language_module = language
    |> Executor.module_for
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

  def std_out_terminated_indicator, do: "________STDOUT________"

  def return_indicator, do: "-_-_-_-_RETURN_-_-_-_-"
  def error_type_indicator, do: "-_-_-_-_ERROR_TYPE_-_-_-_-"
  def error_message_indicator, do: "-_-_-_-_ERROR_MESSAGE_-_-_-_-"

end
