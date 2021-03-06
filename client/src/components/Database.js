import React, { Fragment } from "react"
import { Link } from "react-router-dom";
import Button from '@material-ui/core/Button'

export default function Database(props) {
  const titleCase = function(str) {
    const splitStr = str.toLowerCase().split(/[\s_]+/);
    for (var i = 0; i < splitStr.length; i++) {
        splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);     
    }
    return splitStr.join(' '); 
  }

  const links = function(tables) {
    return tables.map((table) => table.name).sort().map((table, index) => {
      return (
        <Button key={index} style={{margin: '5px', border: '1px solid black'}} component={Link} to={`/database/${table}`}>{titleCase(table)}</Button>
      )
    })
  }

  return (
    <div className="database-page">
      {props.tables.map((table, index) => {
        return (<Fragment key={index}>
          <br/>
          <br/>
          {links(table)}
        </Fragment>)
      })}
    </div>
  )
}