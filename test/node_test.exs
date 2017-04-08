defmodule Executor.Test.Node do
  use ExUnit.Case
  use Maru.Test, for: Executor.Router
  alias Executor.Test.Support.Helpers.Request

  test "should return result for valid nodejs code" do
    {:ok, %{"result" => result}} = %{language: "node", code: "1 + 1"}
    |> Request.post_and_respond("/run") 
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
    {:ok, %{"result" => result}} = %{language: "node", code: code}
    |> Request.post_and_respond("/run") 
    assert result == "woof\n" <>
                     "undefined"
  end
 
  test "should return result with console.log" do
    code = """
    console.log("hello world")
    [1, 2, 3]
    """
    {:ok, %{"result" => result}} = %{language: "node", code: code}
    |> Request.post_and_respond("/run") 
    assert result == "hello world\n" <>
                     "[ 1, 2, 3 ]"
  end
 
  test "should handle and return errors" do
    code = "{{bad::object}}"
    {:ok, %{"result" => result}} = %{language: "node", code: code}
    |> Request.post_and_respond("/run") 
    assert result == "SyntaxError: Unexpected token :"
  end
 
end
