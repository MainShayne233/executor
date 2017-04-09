defmodule Executor.Test do
  use ExUnit.Case
  import Executor
  doctest Executor

  @moduledoc """
  Tests the general Executor module
  """

  test "run/2 should route to the correct module" do
    code = "1 / 0"
    {:error, %{error_type: type, error_message: message}} = code
    |> run("ruby")
    assert type == "ZeroDivisionError"
    assert message == "divided by 0"

    {:ok, %{return: return}} = code
    |> run("node")
    assert return == "Infinity"
  end

  test "run/2 should return error for unsupported language" do
    code = "System.out.println('no');"
    {:error, error} = code
    |> run("java")
    assert error == "Can't run java code"
  end

end
