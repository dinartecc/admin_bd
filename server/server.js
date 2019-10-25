const express = require('express')
const app = express()
const port = 3000
const sql = require('mssql')



const config = {
    user: 'prueba',
    password: '123',
    server: 'DESKTOP-HMJGP6B',
    database: 'taller',
    pool: {
        max: 10,
        min: 0,
        idleTimeoutMillis: 30000
    }
}

app.get('/', (req, res) => {

    res.send('hola');

});

app.get('/select/view', (req, res) => {

    const pool1 = new sql.ConnectionPool(config).connect()
        .then( pool => {
            console.log(req.query.id);
            let query = `select * from dbo.ClienteAuto`;
            console.log(query);
            return pool.query(query);
        })
        .then (result => {
            res.send(result.recordsets)
        })
        .catch (e => {
            res.send(e)
        })
});

app.get('/select/cliente', (req, res) => {

    const pool1 = new sql.ConnectionPool(config).connect()
        .then( pool => {
            console.log(req.query.id);
            let query = `select * from dbo.cliente ${req.query.id !== undefined ? `where ID_Cliente = ${req.query.id}`:''}`;
            console.log(query);
            return pool.query(query);
        })
        .then (result => {
            res.send(result.recordsets)
        })
        .catch (e => {
            res.send(e)
        })

});

app.get('/delete/cliente', (req, res) => {

    if (req.query.id == undefined ) {
        res.send('Debe de mandar el id');
    }
    else {
    const pool1 = new sql.ConnectionPool(config).connect()
    .then( pool => {
        console.log(req.query.id);
        let query = `delete from dbo.cliente where ID_Cliente = ${req.query.id}`;
        console.log(query);
        return pool.query(query);
    })
    .then (result => {
        res.send('Eliminado correctamente')
    })
    .catch (e => {
        res.send(e)
    })}

});

app.listen(port, () => console.log(`Example app listening on port ${port}!`))

