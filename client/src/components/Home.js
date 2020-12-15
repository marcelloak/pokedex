import React from "react"
import { Link } from "react-router-dom";

export default function Home() {

  return (
    <div className="home-page">
      <br/>
      <Link to={`/pokedex`} >Pokedex</Link>
      <br/>
      <Link to={`/database`} >Database Forms</Link>
    </div>
  )
}