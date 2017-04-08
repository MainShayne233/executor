defmodule Executor.Router do
  @moduledoc """
  This is the router module.
  It uses Maru to route an incoming request to the correct module and
  responds with the appropriate JSON.
  As of now, the only module to be routed to is Executor.Runner.
  """
  use Maru.Router
  alias Executor.Runner

  plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Poison,
    parsers: [:urlencoded, :json, :multipart]

  namespace :run do
    params do
      requires :language, type: String
      requires :code,     type: String
    end

    post "/" do
      params
      |> Runner.run
      |> case do
        {:ok,   result} -> conn |> json(%{result: result})
        {:error, error} -> conn |> json(%{error: error})
      end
    end
  end
end
