import React, { useState, useEffect, Fragment } from "react"
import axios from 'axios'
import TextField from '@material-ui/core/TextField'
import Button from '@material-ui/core/Button'

import './Form.css'

export default function Form(props) {
  const [records, setRecords] = useState([])
  const [params, setParams] = useState({})
  const [foreignKeys, setForeignKeys] = useState({})
  const [editing, setEditing] = useState()
  const [sort, setSort] = useState({ key: 'id', asc: true})

  const getForeignKeys = function() {
    props.table.columns.forEach((column) => {
      if (column.name.includes('_id')) {
        axios.get(`/api/${props.table.foreign_keys[column.name.slice(0, -3)] === 'pokemons' || props.table.foreign_keys[column.name.slice(0, -3)] === 'families' ? 'fk/' : ''}${props.table.foreign_keys[column.name.slice(0, -3)]}`)
        .then((response) => {
          setForeignKeys((current) => {
           return { ...current, [column.name]: response.data }
          })
          setParams((current) => {
            return { ...current, [column.name]: params[column.name] ? params[column.name] : (response.data[0] ? response.data[0].id : null)}
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

  const changeSort = function(column) {
    setSort((current) => {
      return { key: column, asc: current.key === column ? !current.asc : true }
    })
  }

  const resetParams = function() {
    const newParams = {}
    if (editing !== false) {
      for (const record of records) {
        if (record.id === editing) {
          props.table.columns.forEach((column) => {
            if (column.name.includes('_id')) newParams[column.name] = record[column.name].id
            else if (column.sql_type_metadata.type === "datetime") newParams[column.name] = record[column.name] ? record[column.name].split('T')[0] : record[column.name]
            else newParams[column.name] = record[column.name]
          })
        }
      }
    }
    else {
      props.table.columns.forEach((column) => {
        if (column.name.includes('_id')) {
          if (foreignKeys[column.name] && foreignKeys[column.name][0]) {
            if (params[column.name]) newParams[column.name] = params[column.name]
            else newParams[column.name] = foreignKeys[column.name][0].id
          }
          else newParams[column.name] = ''
        }
        else if (column.sql_type_metadata.type === "datetime") {
          const now = new Date();
          newParams[column.name] = params[column.name] ? params[column.name] : `${now.getFullYear()}-${now.getMonth() + 1 > 9 ? '' : 0}${now.getMonth() + 1}-${now.getDate() > 9 ? '' : 0}${now.getDate()}`
        }
        else if (column.sql_type_metadata.type === "boolean") {
          newParams[column.name] = false
        }
        else newParams[column.name] = ''
      })
    }
    setParams(newParams)
  }

  useEffect(() => {
    axios.get(`/api/${props.table.name}`)
    .then((response) => {
      setRecords(response.data)
    })
    setEditing(false)
    getForeignKeys()
  }, []);

  useEffect(() => {
    resetParams()
    window.scrollTo(0, 0)
  }, [editing]);

  const clickHandler = () => {
    if (params[props.table.columns[1].name] && props.user) {
      if (editing !== false) {
        axios.put(`/api/${props.table.name}/${editing}`, { ...params })
        .then(() => axios.get(`/api/${props.table.name}`))
        .then((response) => {
          setRecords(response.data)
          setEditing(false)
          props.table.columns.forEach((column) => {
            if (column.name.includes('_id') && props.table.foreign_keys[column.name.slice(0, -3)] === props.table.name) {
              axios.get(`/api/${props.table.foreign_keys[column.name.slice(0, -3)]}`)
              .then((response) => {
                setForeignKeys((current) => {
                 return { ...current, [column.name]: response.data }
                })
                setParams((current) => {
                  return { ...current, [column.name]: params[column.name] ? params[column.name] : (response.data[0] ? response.data[0].id : null)}
                })
              })
            }
          })
        })
      }
      else {
        axios.post(`/api/${props.table.name}`, { ...params })
        .then(() => axios.get(`/api/${props.table.name}`))
        .then((response) => {
          setRecords(response.data)
          resetParams()
          props.table.columns.forEach((column) => {
            if (column.name.includes('_id') && props.table.foreign_keys[column.name.slice(0, -3)] === props.table.name) {
              axios.get(`/api/${props.table.foreign_keys[column.name.slice(0, -3)]}`)
              .then((response) => {
                setForeignKeys((current) => {
                 return { ...current, [column.name]: response.data }
                })
                setParams((current) => {
                  return { ...current, [column.name]: params[column.name] ? params[column.name] : (response.data[0] ? response.data[0].id : null)}
                })
              })
            }
          })
        })
      }
    }
  }

  const submitHandler = (e) => {
    e.preventDefault()
    clickHandler()
  }

  const onChange = (event) => {
    event.persist()
    const name = event.target.name
    setParams((current) => {
      const value = event.target.type === 'checkbox' ? !current[name] : event.target.value
      return { ...current, [name]: value }
    })
  }

  const clearDate = (name) => {
    setParams((current) => {
      return { ...current, [name]: '' }
    })
  }

  const paramFields = function() {
    const columns = props.table.columns.filter((column) => {
      return column.name !== 'id' && column.name !== 'created_at' && column.name !== 'updated_at'
    })
    return columns.map((column, index) => {
      if (column.name in props.table.enums) {
        return (
          <div className='enum-field param-field' key={index}>
            <label htmlFor={column.name}>{titleCase(column.name)}: </label>
            <select onChange={onChange} name={column.name} value={params[column.name] || ''}>
              {Object.keys(props.table.enums[column.name]).map ((key, index) =>{
                return <option key={index} value={key}>{key}</option>
              })}
            </select>
          </div>
        )
      }
      else if (column.name.includes('_id') && foreignKeys[column.name]) {
        return (
          <div className='foreign-key-field param-field' key={index}>
            <label htmlFor={column.name}>{titleCase(column.name)}: </label>
            <select onChange={onChange} name={column.name} value={params[column.name] || ''}>
              <option key={-1} value={''} >None</option>
              {foreignKeys[column.name].map ((key, index) =>{
                const keyName = column.name.includes('costume') || column.name.includes('form') ? `${key.name} (${key.pokemon_id.name})` : key.name
                return <option key={index} value={key.id}>{keyName}</option>
              })}
            </select>
          </div>
        )
      }
      else if (column.sql_type_metadata.type === "boolean") {
        return (
          <div className='boolean-field param-field' key={index}>
            <label htmlFor={column.name}>{titleCase(column.name)}</label>
            <input type="checkbox" name={column.name} checked={params[column.name] || false} onChange={onChange} />
          </div>
        )
      }
      else if (column.sql_type_metadata.type === "datetime") {
        return (
          <div className='datetime-field param-field' key={index}>
            <TextField
              id="date"
              name={column.name}
              label={titleCase(column.name)}
              value={params[column.name] || ''}
              onChange={onChange}
              type="date"
              InputLabelProps={{
                shrink: true,
              }}
            />
            <Button variant="outlined" onClick={() => clearDate(column.name)}>Clear</Button>
          </div>
        )
      }
      else return (
        <div className='text-field param-field' key={index}>
          <TextField id="standard-basic" label={titleCase(column.name)} name={column.name} value={params[column.name] || ''} onChange={onChange}/>
        </div>
      )
    })
  }

  const deleteRecord = function(id) {
    if (props.user && window.confirm('Are you sure you wish to delete this item?')) {
      axios.delete(`/api/${props.table.name}/${id}`)
      .then(() => axios.get(`/api/${props.table.name}`))
      .then((response) => {
        setRecords(response.data)
        getForeignKeys()
      })
    }
  }

  const getRecordRows = function() {
    return (<table>
      <thead>
        <tr>
          {props.table.columns.filter((column) => column.name !== 'created_at' && column.name !== 'updated_at').map((column, index) => {
            return <th key={index} onClick={() => changeSort(column.name)}>{titleCase(column.name)}</th>
          })}
          <th key={props.table.columns.length}>Edit</th>
          <th key={props.table.columns.length + 1}>Delete</th>
        </tr>
      </thead>
      <tbody>
        {records.sort(compare(sort)).map((record, index) => {
          return (
            <tr key={index}>
              {props.table.columns.filter((column) => column.name !== 'created_at' && column.name !== 'updated_at').map((column, index) => {
                if (String(record[column.name]).includes('.png')) return <td key={index}><img src={record[column.name]} alt={record[column.name]} width={30} height={30}/></td>
                else if (String(column.name).includes('_id'))  {
                  if (String(record[column.name].name).includes('.png')) return <td key={index}><img src={record[column.name].name} alt={record[column.name].name} width={30} height={30}/></td>
                  else return <td key={index}>{record[column.name].name}</td>
                }
                else if (column.sql_type_metadata.type === "datetime") return <td key={index}>{record[column.name] ? record[column.name].split('T')[0] : record[column.name]}</td>
                else if (column.sql_type_metadata.type === "boolean") return <td key={index}>{record[column.name] ? 'Y' : ''}</td>
                else return <td key={index}>{record[column.name]}</td>
              })}
              <td key={props.table.columns.length} onClick={() => setEditing(record.id)}>Edit</td>
              <td key={props.table.columns.length + 1} onClick={() => deleteRecord(record.id)}>Delete</td>
            </tr>
          )
        })}
      </tbody>
    </table>)
  }

  return (
    <Fragment>
      <h3>{titleCase(props.table.name) + (records.length ? ` (${records.length})` : '')}</h3>
      <form onSubmit={submitHandler} className={`${props.table.name}-form`}>
        <div className='param-fields' >
          {paramFields()}
        </div>
        <br/>
        <Button variant="outlined" style={{ fontSize: '1em', fontWeight: 'bolder' }} onClick={clickHandler}>Submit</Button>
      </form>
      <br/>
      {getRecordRows()}
    </Fragment>
  )
}