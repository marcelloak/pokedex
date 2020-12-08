import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from './components/Home'
import Nav from './components/Nav'
import Generation from './components/forms/Generation'
import Pokemon from './components/forms/Pokemon'

export default function App() {
  return (
    <Router>
      <Nav />
      <Switch>
        <Route exact path="/" render={(props) => (<Home {...props} />)} />
        <Route path="/generations" render={(props) => (<Generation {...props} />)} />
        <Route path="/pokemon" render={(props) => (<Pokemon {...props} />)} />
      </Switch>
    </Router>
  )
}