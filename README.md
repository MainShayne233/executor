# Executor

Executes your code, REPL style.

[![Build Status](https://travis-ci.org/MainShayne233/executor.svg?branch=master)](https://travis-ci.org/MainShayne233/executor)
[![Coverage Status](https://coveralls.io/repos/github/MainShayne233/executor/badge.svg?branch=master)](https://coveralls.io/github/MainShayne233/executor?branch=master)
[![Code Climate](https://codeclimate.com/github/MainShayne233/executor/badges/gpa.svg)](https://codeclimate.com/github/MainShayne233/executor)

## Warning: This app executes code dangerously, use with caution
The ideal case for this app is to have it deployed in a Docker container with an exposed API where it can do little to no harm.

## Currently Supported Languages
- elixir
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
{:ok, %{return: "2", stdout: ""}}

iex(2)> Executor.Ruby.run "[].upcase"
{:error,
 %{error_message: "undefined method `upcase' for []:Array",
   error_type: "NoMethodError", return: nil, stdout: ""}}

iex(3)> Executor.Ruby.run "puts 'hello'; [1,2,3]"
{:ok, %{return: "[1, 2, 3]", stdout: "hello"}}

# node
iex(4)> Executor.Node.run "1 + 1"
{:ok, %{return: "2", stdout: ""}}

iex(5)> Executor.Node.run "1 / 0"
{:ok, %{return: "Infinity", stdout: ""}}

iex(6)> Executor.Node.run "apple.juice()"
{:error,
 %{error_message: "apple is not defined", error_type: "ReferenceError",
   return: nil, stdout: ""}}
iex(7)> Executor.Node.run "console.log('hello world')"        

{:ok, %{return: "undefined", stdout: "hello world"}}

# elixir
iex(9)> Executor.Elixir.run "1 + 1"
{:ok, %{return: "2", stdout: ""}}

iex(10)> Executor.Elixir.run "0 / 0"
{:error,
 %{error_message: "bad argument in arithmetic expression",
   error_type: "ArithmeticError", return: nil, stdout: ""}}

iex(11)> Executor.Elixir.run "IO.puts \"hello world\""
{:ok, %{return: ":ok", stdout: "hello world"}}

# pass language as argument
iex(12)> Executor.run "ruby", "1 + 1"                 
{:ok, %{return: "2", stdout: ""}}
```
