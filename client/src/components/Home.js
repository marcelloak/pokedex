import React from "react"
import { Link } from "react-router-dom";

export default function Home() {
  return (
    <div className="home-page">
      <Link to={'/generations'} >Generations</Link>
      <br/>
      <Link to={'/pokemon'} >Pokemon</Link>
    </div>
  )
}