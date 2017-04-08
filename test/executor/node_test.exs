defmodule Executor.Test.Node do
  use ExUnit.Case
  alias Executor.Node

  test "should return result for valid nodejs code" do
    code = "1 + 1"
    {:ok, result} = code
    |> Node.run
    assert result == "2"
  end

  test "should be able to define classes" do
    code = """
    class Dog {
      
      bark() {
        console.log('woof')
      }
    }

    const dog = new Dog
    dog.bark()
    """
    {:ok, result} = code
    |> Node.run
    assert result == "woof\n" <>
                     "undefined"
  end

  test "should return result with console.log" do
    code = """
    console.log("hello world")
    [1, 2, 3]
    """
    {:ok, result} = code
    |> Node.run
    assert result == "hello world\n" <>
                     "[ 1, 2, 3 ]"
  end

  test "should handle and return errors" do
    code = "{{bad::object}}"
    {:ok,  result} = code
    |> Node.run
    assert result == "SyntaxError: Unexpected token :"
  end
end
