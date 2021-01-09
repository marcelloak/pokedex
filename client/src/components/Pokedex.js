import React from "react"
import { Link } from "react-router-dom";
import Button from '@material-ui/core/Button'

export default function Pokedex() {
  return (
    <div className="pokedex-page">
      <br/>
      <Button component={Link} to='pokedex/type_chart'>Type Chart</Button>
    </div>
  )
}