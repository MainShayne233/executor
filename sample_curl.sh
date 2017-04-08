curl -H "Content-Type: application/json" -X POST  -d '{
  "language": "ruby",
  "code": "[1,2,3].map {|i| 2 * i}"

}' 'localhost:8888/run'
