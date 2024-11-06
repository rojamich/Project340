/*
  SETUP
*/
var fs = require("fs")
var express = require('express')
var exphbs = require('express-handlebars')

var app = express()
var port = process.env.PORT || 3000

app.engine('handlebars', exphbs.engine({ defaultLayout: 'main' }))
app.set('view engine', 'handlebars')

app.use(function (req, res, next) {
    console.log("== New Request")
    console.log(" -- URL:", req.url)
    console.log(" -- Method:", req.method)

    console.log("----------------------------------------------------")
    next()
})

app.use(express.json())
app.use(express.static('static'))

var customersData = require('./customersData.json')

/*
  ROUTES
*/
app.get('/', function (req, res, next) {
  res.status(200).render('homePage')
})

app.get('/customers', function (req, res, next) {
  res.status(200).render('customersPage', {customers: customersData})
})

app.get('*', function (req, res, next) {
    res.status(404).render('404', {
      page: req.url
    })
  })

/*
  LISTENER
*/
app.listen(port, function () {
    console.log("== Server listening on port", port)
  })