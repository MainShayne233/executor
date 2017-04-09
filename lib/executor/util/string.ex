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

    iex> remove_trailing_newline("apple\\n")
    "apple"

    iex> remove_trailing_newline("apple")
    "apple"
  """

  def remove_trailing_newline(result) do
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
  Return the string with preceading newline removed if one
  existed

    iex> remove_preceading_newline("\\napple")
    "apple"

    iex> remove_preceading_newline("apple")
    "apple"
  """

  def remove_preceading_newline(result) do
    result
    |> String.codepoints
    |> List.first
    |> case do
      "\n" -> result |> String.slice(1..-1)
      _    -> result
    end
  end


  @doc """
  Returns string with newlines removes from beginning of end

    iex> trim_newlines("\\napple\\n")
    "apple"

    iex> trim_newlines("apple\\n")
    "apple"

    iex> trim_newlines("\\napple")
    "apple"

    iex> trim_newlines("apple")
    "apple"
  """

  def trim_newlines(string) do
    string
    |> remove_trailing_newline
    |> remove_preceading_newline
  end

  @doc """
  Returns the string found between two instances of the delimiter

    iex> match_between("applejuiceapple", "apple")
    "juice"

    iex> match_between("applejuiceapple", "orange")
    nil
  """

  def match_between(string, delimiter) do
    string
    |> String.split(delimiter)
    |> case do
      [_, match, _] -> match
      _             -> nil
    end
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
