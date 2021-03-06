import React from "react"
import { Link } from "react-router-dom";
import Button from '@material-ui/core/Button'

export default function Pokedex(props) {
  const titleCase = function(str) {
    const splitStr = str.toLowerCase().split(/[\s_]+/);
    for (var i = 0; i < splitStr.length; i++) {
        splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);     
    }
    return splitStr.join(' '); 
  }

  const links = function(routes) {
    return routes.map((route, index) => {
      return (
        <Button key={index} style={{margin: '5px', border: '1px solid black'}} component={Link} to={`/pokedex/${route}`}>{titleCase(route)}</Button>
      )
    })
  }
  return (
    <div className="pokedex-page">
      <br/>
      <Button style={{margin: '5px', border: '1px solid black'}} component={Link} to='pokedex/type_chart'>Type Chart</Button>
      {links(props.routes)}
    </div>
  )
}