import React, { Fragment } from "react"
import { Link } from "react-router-dom";

export default function Home(props) {
  const titleCase = function(str) {
    const splitStr = str.toLowerCase().split(/[\s_]+/);
    for (var i = 0; i < splitStr.length; i++) {
        splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);     
    }
    return splitStr.join(' '); 
  }

  const tableLinks = function() {
    return props.tables.map((table, index) => {
      return (
        <Fragment key={index}>
          <Link to={`/${table.name}`} >{titleCase(table.name)}</Link>
          <br/>
        </Fragment>
      )
    })
  }

  return (
    <div className="home-page">
      {tableLinks()}
    </div>
  )
}