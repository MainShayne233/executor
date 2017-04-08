# Executor

This is a [Maru] based REST API app that you can run and use to execute raw code.

## Warning: This app executes code dangerously, use with caution
The ideal case for this app is to have it deployed in a Docker container where it can do little to no harm.

## Currently Supported Languages
- ruby
- node (any Javascript that Node can run)

## Usage

Make sure that you have whatever language you want to use
installed/available on the machine you will be running this on.

```bash
git clone https://github.com/MainShayne233/executor
cd executor
iex mix deps.get
iex -S mix
```

Then you can send requests to [localhost:8888]

To use different port:
```bash
PORT=9000 iex -S mix
```


## Requests

Current routes:
- /run

### /run
sample curl request:

```bash
curl -H "Content-Type: application/json" -X POST  -d '{
  "language": "ruby",
  "code": "[1,2,3].map {|i| 2 * i}"

}' 'localhost:8888/run'

# response
{"result":"=> [2, 4, 6]"}

```

[Maru]: (https://maru.readme.io/docs)
[localhost:8888]: (http://localhost:8888)
