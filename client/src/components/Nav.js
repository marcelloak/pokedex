import React from "react"
import { Link } from "react-router-dom";

export default function Nav() {
  return (
    <div className="nav-bar">
      <Link to={'/'} >Home</Link>
    </div>
  )
}