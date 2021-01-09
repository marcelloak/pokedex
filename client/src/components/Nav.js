import React from "react"
import { Link } from "react-router-dom";
import Button from '@material-ui/core/Button'

export default function Nav(props) {
  return (
    <div className="nav-bar">
      <Button component={Link} to="/pokedex">Pokedex</Button>
      <Button component={Link} to="/database">Forms</Button>
      {!props.user && (
        <Button component={Link} to="/user">Login</Button>
      )}
    </div>
  )
}