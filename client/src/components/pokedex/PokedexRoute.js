import React from "react"

export default function PokedexRoute(props) {
  const titleCase = function(str) {
    const splitStr = str.toLowerCase().split(/[\s_]+/);
    for (var i = 0; i < splitStr.length; i++) {
        splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);     
    }
    return splitStr.filter(str => str !== 'Id').join(' '); 
  }

  return (
    <h3>{titleCase(props.route)}</h3>
  )
}