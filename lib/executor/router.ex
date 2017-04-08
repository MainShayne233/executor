defmodule Executor.Router do
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
        {:ok, result} -> conn |> json(%{result: result})
        {:error, error} -> conn |> json(%{error: error})
      end
    end
  end

end

