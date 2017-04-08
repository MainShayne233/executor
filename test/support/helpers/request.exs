defmodule Executor.Test.Support.Helpers.Request do
  use ExUnit.Case
  use Maru.Test, for: Executor.Router

  def post_and_respond(body, url) do
    build_conn()
    |> Plug.Conn.put_req_header("content-type", "application/json")
    |> put_body_or_params(Poison.encode!(body))
    |> post(url)
    |> Map.get(:resp_body)
    |> Poison.decode
  end
end
