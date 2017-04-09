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

  test "run/2 should return error for unsupported language" do
    code = "1 / 0"
    {:error, error} = "java"
    |> Executor.run(code)
    assert error == "Can't run java code"
  end

end
