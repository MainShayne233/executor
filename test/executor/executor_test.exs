defmodule Executor.Test do
  use ExUnit.Case

  test "run/2 should route to the correct module" do
    code = "1 + 1"
    {:ok, result} = "ruby" 
    |> Executor.run(code)
    assert result == "=> 2"

    {:ok, result} = "node" 
    |> Executor.run(code)
    assert result == "2"
  end

end
