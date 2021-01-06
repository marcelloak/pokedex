import React, { useState, useEffect, Fragment } from "react"
import axios from 'axios'

import './TypeChart.css'

export default function TypeChart() {
  const [typeInteractions, setTypeInteractions] = useState([])

  useEffect(() => {
    axios.get(`/api/type_chart`)
    .then((response) => {
      setTypeInteractions(response.data)
    })
  }, []);

  const getChart = function() {
    return (<table>
      <thead>
        <tr>
          <th key={-1}></th>
          {typeInteractions.map((type, index) => {
            return <th key={index}>{<img src={type[0].icon} alt={type[0].name} width={30} height={30}/>}</th>
          })}
        </tr>
      </thead>
      <tbody>
        {typeInteractions.map((type, index) => {
          return (
            <tr key={index}>
              {type.map((interaction, index) => {
                let bgColor = 'white';
                if (interaction.multiplier === 2) bgColor = 'green'
                else if (interaction.multiplier === 0.25) bgColor = 'grey'
                else if (interaction.multiplier === 0.5) bgColor = 'red'
                return <td key={index} style={{backgroundColor: bgColor}} >{index ? '' : <img src={interaction.icon} alt={interaction.name} width={30} height={30}/>}</td>
              })}
            </tr>
          )
        })}
      </tbody>
    </table>)
  }

  return (
    <Fragment>
      <br/>
      {getChart()}
    </Fragment>
  )
}