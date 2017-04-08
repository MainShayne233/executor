defmodule Executor.Util.String do
  @moduledoc """
  This module contains convienent helper functions related to strings
  """

  def titleize(string) do
    [first | rest] = string
    |> String.downcase
    |> String.codepoints
    String.upcase(first) <> Enum.join(rest, "")
  end

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
end
