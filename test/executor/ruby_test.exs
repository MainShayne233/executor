defmodule Executor.Test.Ruby do
  use ExUnit.Case
  alias Executor.Ruby

  test "should return valid result for ruby code" do
    code = "1 + 1"
    {:ok, result} = code 
    |> Ruby.run
    assert result == "=> 2"
  end


  test "should show print/put statements in results" do
    code = """
    puts "hello world"
    [1, 2, 3]
    """
    {:ok, result} = code 
    |> Ruby.run
    assert result == "hello world\n" <>
                     "=> [1, 2, 3]"
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
    {:ok, result} = code 
    |> Ruby.run
    assert result == "woof!\n" <>
                     "=> nil"
  end

  test "should handle and return errors" do
    code = """
    0 / 0
    """
    {:ok, result} = code 
    |> Ruby.run
    assert result == "ZeroDivisionError: divided by 0"

    code = """
    {"wrong" <= "way"}
    """
    {:ok, result} = code 
    |> Ruby.run
    assert result == "SyntaxError: (eval):2: syntax error, unexpected '}', " <>
                     "expecting =>"

  end
end
