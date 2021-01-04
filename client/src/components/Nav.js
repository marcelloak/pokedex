import React from "react"
import { Link } from "react-router-dom";

export default function Nav() {
  return (
    <div className="nav-bar">
      <Link to={'/'} >Home</Link>
      <br/>
      <Link to={`/pokedex`} >Pokedex</Link>
      <br/>
      <Link to={`/database`} >Database Forms</Link>
    </div>
  )
}