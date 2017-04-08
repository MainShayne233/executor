use Mix.Config

config :maru, Executor.Router,
  http: [port: System.get_env("PORT") || 8888]
