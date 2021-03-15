const http = require('http')

const port = 3000

http.createServer((req, res) => {
  let body = 'It works!'
  res.writeHead(200, {
    'Content-Type': 'text/html',
    'Content-Length': body.length
  })
  res.write(body)
  res.end()
}).listen(port)
