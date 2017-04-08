defmodule Executor.Utils.String do

  def titleize(string) do
    [first | rest] = string 
    |> String.downcase
    |> String.codepoints
    String.upcase(first) <> Enum.join(rest, "")
  end
end
