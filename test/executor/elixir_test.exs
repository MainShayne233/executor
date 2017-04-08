defmodule Executor.Test.Elixir do
  use ExUnit.Case

  test "should return valid result for elixir code" do
    code = "1 + 1"
    {:ok, result} = code
    |> Executor.Elixir.run
    assert result == "2"
  end


  test "should show print/put statements in results" do
    code = """
    IO.puts "hello world"
    [1, 2, 3]
    """
    {:ok, result} = code
    |> Executor.Elixir.run
    assert result == "hello world\n" <>
                     "[1, 2, 3]"
  end

  test "can define modules" do
    code = """
    defmodule Dog do
      def bark, do: IO.puts "woof!"
    end

    Dog.bark()
    """
    {:ok, result} = code
    |> Executor.Elixir.run
    assert result == "woof!\n" <>
                     ":ok"
  end

  test "should handle and return errors" do
    code = """
    0 / 0
    """
    {:ok, result} = code
    |> Executor.Elixir.run
    assert result == "** (ArithmeticError) bad argument in arithmetic expression"

    code = """
    %{"wrong" <= "way"}
    """
    {:ok, result} = code
    |> Executor.Elixir.run
    assert result == "** (SyntaxError) syntax error before: '}'"

  end
end
