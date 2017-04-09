defmodule Executor.Test do
  use ExUnit.Case

  test "run/2 should route to the correct module" do
    code = "1 / 0"
    {:error, %{error_type: type, error_message: message}} = "ruby"
    |> Executor.run(code)
    assert type == "ZeroDivisionError"
    assert message == "divided by 0"

    {:ok, %{return: return}} = "node"
    |> Executor.run(code)
    assert return == "Infinity"
  end

end
