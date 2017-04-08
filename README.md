# Executor

Executes your code, REPL style.

## Warning: This app executes code dangerously, use with caution
The ideal case for this app is to have it deployed in a Docker container with an exposed API where it can do little to no harm.

## Currently Supported Languages
- ruby
- node (any Javascript that Node can run)

## Install

Make sure that you have whatever language(s) you want to use
installed/available on the machine you will be running this on.

Add executor to you dependencies in `mix.exs`

```elixir
defp deps do
  [
    {:executor, git: "https://github.com/MainShayne233/executor.git"},
  ]
end

```

Then install
```bash
mix deps.get
```

## Usage

Common API looks like: Executor.Language.run("code as string")

Example in IEx:
```elixir
# ruby
iex(2)> Executor.Ruby.run "1 + 1"
{:ok, "=> 2"} # notice this reflects the output from using irb (the Ruby REPL)
iex(3)> Executor.Ruby.run "0 / 0"
{:ok, "ZeroDivisionError: divided by 0"}
iex(4)> Executor.Ruby.run "puts 'hello world'; [1,2,3]"
{:ok, "hello world\n=> [1, 2, 3]"}

# node
iex(5)> Executor.Node.run "1 + 1"
{:ok, "2"}
iex(6)> Executor.Node.run "{hi::there"
{:ok, "SyntaxError: Unexpected token :"}
iex(7)> Executor.Node.run "console.log('hello world'); [1,2,3]"
{:ok, "hello world\n[ 1, 2, 3 ]"}

# pass language as argument
iex(8)> Executor.run "ruby", "[1,2,3].map{|i| 2 * i}"
{:ok, "=> [2, 4, 6]"}
```
