defmodule Executor.Test.Node do
  use ExUnit.Case
  alias Executor.Node
  import Node
  doctest Node

  @moduledoc """
  Tests the Node module
  """

  test "should return result for valid nodejs code" do
    code = "1 + 1"
    {:ok, %{return: return, stdout: stdout}} = code
    |> Node.run
    assert return == "2"
    assert stdout == ""
  end

  test "should be able to define functions" do
    code = """
    function dogBark() {
      console.log('woof!')
    }

    dogBark()
    """
    {:ok, %{return: return, stdout: stdout}} = code
    |> Node.run
    assert return == "undefined"
    assert stdout == "woof!"
  end

  test "should return result with console.log" do
    code = """
    console.log("hello world")
    [1, 2, 3]
    """
    {:ok, %{return: return, stdout: stdout}} = code
    |> Node.run
    assert return == "[ 1, 2, 3 ]"
    assert stdout == "hello world"
  end

  test "should handle and return errors" do
    code = "{{bad::object}}"
    {:error, %{error_type: type, error_message: message}} = code
    |> Node.run
    assert type == "SyntaxError"
    assert message
  end
end
