defmodule Executor.Utils.String do
  @moduledoc """
  This module contains convienent helper functions related to strings
  """

  def titleize(string) do
    [first | rest] = string
    |> String.downcase
    |> String.codepoints
    String.upcase(first) <> Enum.join(rest, "")
  end
end
