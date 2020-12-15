import React from "react"
import { Link } from "react-router-dom";

export default function Pokedex() {
  return (
    <div className="pokedex-page">
      <br/>
      <Link to={`/pokedex/type_chart`} >Type Chart</Link>
    </div>
  )
}