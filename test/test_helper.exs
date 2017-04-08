Maru.Test.start()
ExUnit.start()

[
  "test/support/helpers",
]
|> Enum.each(fn api_test_path ->
  api_test_path
  |> Path.join("**/*.exs")
  |> Path.wildcard
  |> Enum.map(fn path -> Code.load_file(path) end)
end)
