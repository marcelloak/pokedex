import React, { Fragment } from "react"
import { Link } from "react-router-dom";

export default function Nav(props) {
  return (
    <div className="nav-bar">
      <Link to={'/'} >Home</Link>
      <br/>
      <Link to={`/pokedex`} >Pokedex</Link>
      <br/>
      <Link to={`/database`} >Database Forms</Link>
      {!props.user && (
        <Fragment>
          <br/>
          <Link to={`/user`} >Login</Link>
        </Fragment>
      )}
    </div>
  )
}