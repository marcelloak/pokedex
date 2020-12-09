import React, { useState, useEffect, Fragment } from "react"
import axios from 'axios'
import TextField from '@material-ui/core/TextField'
import Button from '@material-ui/core/Button'

export default function Form(props) {
  const [records, setRecords] = useState([])
  const [params, setParams] = useState({})
  const [foreignKeys, setForeignKeys] = useState({})

  const getForeignKeys = function() {
    props.table.columns.forEach((column) => {
      if (column.name.includes('_id')) {
        axios.get(`/api/${props.table.foreign_keys[column.name.slice(0, -3)]}`)
        .then((response) => {
          setForeignKeys((current) => {
           return { ...current, [column.name]: response.data }
          })
          setParams((current) => {
            return { ...current, [column.name]: response.data[0] ? response.data[0].id : null}
          })
        })
      }
    })
  }

  const titleCase = function(str) {
    const splitStr = str.toLowerCase().split(/[\s_]+/);
    for (var i = 0; i < splitStr.length; i++) {
        splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);     
    }
    return splitStr.filter(str => str !== 'Id').join(' '); 
  }

  const resetParams = function() {
    const newParams = {}
    props.table.columns.forEach((column) => {
      newParams[column.name] = ''
    })
    setParams(newParams)
  }

  useEffect(() => {
    axios.get(`/api/${props.table.name}`)
    .then((response) => {
      setRecords(response.data)
    })
    resetParams()
    getForeignKeys()
  }, []);

  const clickHandler = () => {
    if (params[props.table.columns[1].name]) {
      axios.post(`/api/${props.table.name}`, { ...params })
      .then(() => axios.get(`/api/${props.table.name}`))
      .then((response) => {
       setRecords(response.data)
       resetParams()
      })
    }
  }

  const submitHandler = (e) => {
    e.preventDefault()
    clickHandler()
  }

  const onChange = (event) => {
    const value = event.target.value
    const name = event.target.name
    setParams((current) => {
     return { ...current, [name]: value }
    })
  }

  const paramFields = function() {
    console.log(props.table.columns)
    const columns = props.table.columns.filter((column) => {
      return column.name !== 'id' && column.name !== 'created_at' && column.name !== 'updated_at'
    })
    return columns.map((column, index) => {
      if (column.name.includes('_id') && foreignKeys[column.name]) {
        return (
          <Fragment key={index}>
            <label htmlFor={column.name}>{titleCase(column.name)}: </label>
            <select onChange={onChange} name={column.name}>
              {foreignKeys[column.name].map ((key, index) =>{
                return <option key={index} value={key.id}>{key.name}</option>
              })}
            </select>
            <br/>
          </Fragment>
        )
      }
      else if (column.sql_type_metadata.type === "boolean") {
        return (
          <Fragment key={index}>
            <label htmlFor={column.name}>{titleCase(column.name)}</label>
            <input type="checkbox" name={column.name} value={params[column.name] || ''} onChange={onChange} />
            <br/>
          </Fragment>
        )
      }
      else return (
        <Fragment key={index}>
          <TextField id="standard-basic" label={titleCase(column.name)} name={column.name} value={params[column.name] || ''} onChange={onChange}/>
          <br/>
        </Fragment>
      )
    })
  }

  return (
    <Fragment>
      {records.map((record, index) => {
        return <p key={index}>{record.name || ''}</p>
      })}
      <form onSubmit={submitHandler} className={`${props.table.name}-form`}>
        {paramFields()}
        <Button variant="outlined" style={{ fontSize: '1em', fontWeight: 'bolder' }} onClick={clickHandler}>Submit</Button>
      </form>
    </Fragment>
  )
}