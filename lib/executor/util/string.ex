defmodule Executor.Util.String do
  @moduledoc """
  This module contains convienent helper functions related to strings
  """

  @doc """
  Returns the string with the first letter uppercase
  and the rest of the letters lowercase

    iex> titleize("apple")
    "Apple"

    iex> titleize("APPLE")
    "Apple"
  """

  def titleize(string) do
    [first | rest] = string
    |> String.downcase
    |> String.codepoints
    String.upcase(first) <> Enum.join(rest, "")
  end

  @doc """
  Return the string with trailing newline removed if one
  existed

    iex> remove_trailing_new_line("apple\\n")
    "apple"

    iex> remove_trailing_new_line("apple")
    "apple"
  """

  def remove_trailing_new_line(result) do
    result
    |> String.reverse
    |> String.codepoints
    |> List.first
    |> case do
      "\n" -> result |> String.slice(0..-2)
      _    -> result
    end
  end

  @doc """
  Returns the string found between two instances of the delimiter

    iex> match_between("apple", "applejuiceapple")
    "juice"

    iex> match_between("orange", "applejuiceapple")
    nil
  """

  def match_between(delimiter, string) do
    ~r/#{delimiter}\n?(.*)\n?#{delimiter}/
    |> Regex.scan(string)
    |> List.flatten
    |> List.last
  end

  @doc """
  Replaces newlines with semi-colons

    iex> semicolonize("java\\nscript")
    "java;script"
  """

  def semicolonize(string) do
    string
    |> String.split("\n")
    |> Enum.join(";")
  end
end
