import React, { useState, useEffect, Fragment } from "react"
import axios from 'axios'

export default function PokedexRoute(props) {
  const [columns, setColumns] = useState([])
  const [records, setRecords] = useState([])
  const [sort, setSort] = useState({ key: 'id', asc: true})

  useEffect(() => {
    axios.get(`/${props.route}`)
    .then((response) => {
      setColumns(response.data[0])
      setRecords(response.data.slice(1))
    })
  }, []);

  const titleCase = function(str) {
    const splitStr = str.toLowerCase().split(/[\s_]+/);
    for (var i = 0; i < splitStr.length; i++) {
        splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);     
    }
    return splitStr.filter(str => str !== 'Id').join(' '); 
  }

  const changeSort = function(column) {
    setSort((current) => {
      return { key: column, asc: current.key === column ? !current.asc : true }
    })
  }

  const compare = function(sort) {
    const c = function(a, b) {
      if (a[sort.key] && b[sort.key]) {
        if (a[sort.key].name || b[sort.key].name) {
          if (a[sort.key].name && b[sort.key].name) {
            if (a[sort.key].name < b[sort.key].name) return sort.asc ? -1 : 1
            if (a[sort.key].name > b[sort.key].name) return sort.asc ? 1 : -1
            return 0
          }
          else if (a[sort.key].name) return sort.asc ? -1 : 1
          else if (b[sort.key].name) return sort.asc ? 1 : -1
          else return 0
        }
        else {
          if (a[sort.key] < b[sort.key]) return sort.asc ? -1 : 1
          if (a[sort.key] > b[sort.key]) return sort.asc ? 1 : -1
          return 0
        }
      }
      else if (a[sort.key]) return sort.asc ? -1 : 1
      else if (b[sort.key]) return sort.asc ? 1 : -1
      else return 0
    }

    return c
  }

  const getDisplay = function() {
    if (records.length === 0) return <p>None</p>
    if (records.length === 1) return (
      columns.filter((column) => column !== 'created_at' && column !== 'updated_at').map((column, index) => {
        if (String(records[0][column]).includes('.png')) return <p key={index}>{titleCase(column)}: <img src={records[0][column]} alt={records[0][column]} width={30} height={30}/></p>
        if (column.includes('_id')) {
          if (String(records[0][column].name).includes('.png')) return <p key={index}>{titleCase(column)}: <img src={records[0][column].name} alt={records[0][column].name} width={30} height={30}/></p>
          return <p key={index}>{titleCase(column)}: {records[0][column].name}</p>
        }
        return <p key={index}>{titleCase(column)}: {String(records[0][column]).includes('T00:00:00.000Z') ? records[0][column].split('T')[0] : records[0][column]}</p>
      })
    )
    return getRecordRows()
  }

  const getRecordRows = function() {
    return (<table>
      <thead>
        <tr>
          {columns.filter((column) => column !== 'created_at' && column !== 'updated_at').map((column, index) => {
            return <th key={index} onClick={() => changeSort(column)} >{titleCase(column)}</th>
          })}
        </tr>
      </thead>
      <tbody>
        {records.sort(compare(sort)).map((record, index) => {
          return (
            <tr key={index}>
              {columns.filter((column) => column !== 'created_at' && column !== 'updated_at').map((column, index) => {
                if (String(record[column]).includes('.png')) return <td key={index}><img src={record[column]} alt={record[column]} width={30} height={30}/></td>
                else if (String(column).includes('_id'))  {
                  if (String(record[column].name).includes('.png')) return <td key={index}><img src={record[column].name} alt={record[column].name} width={30} height={30}/></td>
                  else return <td key={index}>{record[column].name}</td>
                }
                else if (String(record[column]).includes('T00:00:00.000Z')) return <td key={index}>{record[column].split('T')[0]}</td>
                else if (record[column] === true) return <td key={index}>Y</td>
                else return <td key={index}>{record[column]}</td>
              })}
            </tr>
          )
        })}
      </tbody>
    </table>)
  }

  return (
    <Fragment>
      <h3>{titleCase(props.route)}</h3>
      {getDisplay()}
    </Fragment>
  )
}