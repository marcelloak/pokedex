import React, { useState, useEffect } from "react"
import axios from 'axios'
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from './components/Home'
import Nav from './components/Nav'
import Form from './components/Form'
import Database from './components/Database'
import Pokedex from './components/Pokedex'
import TypeChart from './components/pokedex/TypeChart'

export default function App() {
  const [tables, setTables] = useState([])
  const [timelineTables, setTimelineTables] = useState([])
  const [caughtTables, setCaughtTables] = useState([])

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
  }, []);

  const tableRoutes = function() {
    return tables.map((table, index) => {
      return <Route key={index} path={`/database/${table.name}`} render={(props) => (<Form {...props} table={table} />)} />
    })
  }

  const timelineTableRoutes = function() {
    return timelineTables.map((table, index) => {
      return <Route key={index} path={`/database/${table.name}`} render={(props) => (<Form {...props} table={table} />)} />
    })
  }

  const caughtTableRoutes = function() {
    return caughtTables.map((table, index) => {
      return <Route key={index} path={`/database/${table.name}`} render={(props) => (<Form {...props} table={table} />)} />
    })
  }

  return (
    <Router>
      <Nav/>
      <Switch>
        <Route exact path="/" component={Home} />
        <Route exact path="/database" render={(props) => (<Database {...props} tables={[caughtTables, tables, timelineTables]} timelineTables={timelineTables} caughtTables={caughtTables} />)} />
        {tableRoutes()}
        {timelineTableRoutes()}
        {caughtTableRoutes()}
        <Route exact path="/pokedex" component={Pokedex} />
        <Route exact path="/pokedex/type_chart" component={TypeChart} />
      </Switch>
    </Router>
  )
}