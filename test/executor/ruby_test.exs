defmodule Executor.Test.Ruby do
  use ExUnit.Case
  alias Executor.Ruby

  test "should return valid result for ruby code" do
    code = "1 + 1"
    {:ok, %{return: return, stdout: stdout}} = code
    |> Ruby.run
    assert return == "2"
    assert stdout == ""
  end

  test "should show print/put statements in results" do
    code = """
    puts "hello world"
    [1, 2, 3]
    """
    {:ok, %{return: return, stdout: stdout}} = code
    |> Ruby.run
    assert return == "[1, 2, 3]"
    assert stdout == "hello world"
  end

  test "can define classes" do
    code = """
    class Dog
      
      def bark
        puts "woof!"
      end
    end

    dog = Dog.new
    dog.bark
    """
    {:ok, %{return: return, stdout: stdout}} = code
    |> Ruby.run
    assert return == "nil"
    assert stdout == "woof!"
  end

  test "should handle and return errors" do
    code = """
    0 / 0
    """
    {:error, %{error_type: type, error_message: message}} = code
    |> Ruby.run
    assert type == "ZeroDivisionError"
    assert message == "divided by 0"

    code = """
    {"wrong" <= "way"}
    """
    {:error, %{error_type: type, error_message: message}} = code
    |> Ruby.run
    assert type == "SyntaxError"
    assert message in [
      "(eval):2: syntax error, unexpected '}', expecting =>",
      "(eval):2: syntax error, unexpected '}', expecting tASSOC",
    ]
  end
end
