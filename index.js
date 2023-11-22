const express = require('express')
const mustacheExpress = require('mustache-express')
const session = require('express-session')
const db = require('./src/db')

const app = express()

app.engine('html', mustacheExpress())
app.set('view engine', 'html')
app.set('views', __dirname + '/src/views')

app.use(express.urlencoded({extended: true}))
app.use(express.json());
app.use(express.static(__dirname + '/public'));

app.use(session({
    secret: 'secret-token',
    name: 'sessionId',  
    resave: false,
    saveUninitialized: false
}))

app.use('/', require('./src/routes/user.routes'));
app.use('/', require('./src/routes/product.routes'));

db.sync(() => console.log(`Database connected!`));

const app_port = 8080
app.listen(app_port, () => {
    console.log(`Server started on port ${app_port}`);
})
