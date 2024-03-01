# CornerbackDemo

A sample project to show the Cornerback library usage inside a project.

## Demo server

I use a Nodejs server in this project, to create it, please follow these steps

1. Create a folder named `CornerbackServer`
2. Indide that folder create a file named `server.js` with the content of the script below
3. In Terminal, type the following command `npm init`
4. Use the defaults values proposed by Nodejs

To launch the server execute `npm start`

```javascript
const express = require('express')
const app = express()
const port = 3000

function getDetails(request) {
    let details = {
        "scheme" : request.protocol,
        "domain" : request.hostname,
        "resource" : request.path,
        "query" : request.query,
        "headers" : request.headers
    }

    let result = JSON.stringify(details, null, 4)
    
    return result;
}

app.get('/', (request, response) => {
    let result = getDetails(request);
    response.send(`<pre style="font-size: 24pt;">${result}</pre>`)
})

app.get('/cornerback', (request, response) => {
    let result = getDetails(request);
    response.send(result);
})

app.listen(port, (err) => {
    if (err) {
        return console.log('something bad happened', err)
    }

    console.log(`server is listening on ${port}`)
})
```

The server will return the information provided by the iOS application request, check in the application the response provided by the server to check that the Cornerback rules have been applied.
