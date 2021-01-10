import React, { useState, useEffect } from "react"
import axios from 'axios'
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Cookies from 'universal-cookie';

import Nav from './components/Nav'
import Form from './components/Form'
import Login from './components/Login'
import Database from './components/Database'
import Pokedex from './components/Pokedex'
import TypeChart from './components/pokedex/TypeChart'
import PokedexRoute from './components/pokedex/PokedexRoute'

export default function App() {
  const cookies = new Cookies()

  const [tables, setTables] = useState([])
  const [timelineTables, setTimelineTables] = useState([])
  const [caughtTables, setCaughtTables] = useState([])
  const [routes, setRoutes] = useState([])
  const [user, setUser] = useState(cookies.get('user'))

  useEffect(() => {
    axios.get('/tables')
    .then((response) => {
      setTables(response.data)
    })
    axios.get('/timeline_tables')
    .then((response) => {
      setTimelineTables(response.data)
    })
    axios.get('/caught_tables')
    .then((response) => {
      setCaughtTables(response.data)
    })
    axios.get('/routes')
    .then((response) => {
      setRoutes(response.data)
    })
  }, []);

  const tableRoutes = function(tables) {
    return tables.map((table, index) => {
      return (
          <Route key={index} path={`/database/${table.name}`} render={(props) => (<Form {...props} user={user} table={table} />)} />
      )
    })
  }

  const pokedexRoutes = function(routes) {
    return routes.map((route, index) => {
      return (
          <Route key={index} path={`/pokedex/${route}`} render={(props) => (<PokedexRoute {...props} route={route} />)} />
      )
    })
  }

  return (
    <Router>
      <Nav user={user} />
      <Switch>
        <Route exact path="/user" render={(props) => (<Login {...props} cookies={cookies} user={user} setUser={setUser} />)} />
        <Route exact path="/database" render={(props) => (<Database {...props} tables={[caughtTables, tables, timelineTables]} timelineTables={timelineTables} caughtTables={caughtTables} />)} />
        {tableRoutes(tables)}
        {tableRoutes(timelineTables)}
        {tableRoutes(caughtTables)}
        <Route exact path="/pokedex" render={(props) => (<Pokedex {...props} routes={routes} />)} />
        <Route exact path="/pokedex/type_chart" component={TypeChart} />
        {pokedexRoutes(routes)}
      </Switch>
    </Router>
  )
}