defmodule Executor.Test.Elixir do
  use ExUnit.Case

  test "should return valid result for elixir code" do
    code = "1 + 1"
    {:ok, %{return: return, stdout: stdout}} = code
    |> Executor.Elixir.run
    assert return == "2"
    assert stdout == ""
  end

  test "should show print/put statements in results" do
    code = """
    IO.puts "hello world"
    [1, 2, 3]
    """
    {:ok, %{return: return, stdout: stdout}} = code
    |> Executor.Elixir.run
    assert return == "[1, 2, 3]"
    assert stdout == "hello world"
  end

  test "can define modules" do
    code = """
    defmodule Dog do
      def bark, do: IO.puts "woof!"
    end

    Dog.bark()
    """
    {:ok, %{return: return, stdout: stdout}} = code
    |> Executor.Elixir.run
    assert return == ":ok"
    assert stdout == "woof!"
  end

  test "should handle and return errors" do
    code = """
    0 / 0
    """
    {:error, %{error_type: type, error_message: message}} = code
    |> Executor.Elixir.run
    assert type == "ArithmeticError"
    assert message == "bad argument in arithmetic expression"

    code = """
    %{"wrong" <= "way"}
    """
    {:error, %{error_type: type, error_message: message}} = code
    |> Executor.Elixir.run
    assert type == "SyntaxError"
    assert message == "syntax error before: '}'"
  end
end
