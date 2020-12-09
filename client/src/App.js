import React, { useState, useEffect } from "react"
import axios from 'axios'
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from './components/Home'
import Nav from './components/Nav'
import Form from './components/Form'

export default function App() {
  const [tables, setTables] = useState([])

  useEffect(() => {
    axios.get('/tables')
    .then((response) => {
      setTables(response.data)
    })
  }, []);

  const tableRoutes = function() {
    return tables.map((table, index) => {
      return <Route key={index} path={`/${table.name}`} render={(props) => (<Form {...props} table={table} />)} />
    })
  }

  return (
    <Router>
      <Nav />
      <Switch>
        <Route exact path="/" render={(props) => (<Home {...props} tables={tables} />)} />
        {tableRoutes()}
      </Switch>
    </Router>
  )
}