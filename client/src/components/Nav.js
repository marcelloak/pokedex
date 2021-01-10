import React from "react"
import { Link } from "react-router-dom";
import Button from '@material-ui/core/Button'

export default function Nav(props) {
  return (
    <div className="nav-bar">
      <Button style={{margin: '5px', border: '1px solid black'}} component={Link} to="/pokedex">Pokedex</Button>
      <Button style={{margin: '5px', border: '1px solid black'}} component={Link} to="/database">Forms</Button>
      {!props.user && (
        <Button style={{margin: '5px', border: '1px solid black'}} component={Link} to="/user">Login</Button>
      )}
    </div>
  )
}