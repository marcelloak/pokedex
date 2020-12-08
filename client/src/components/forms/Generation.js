import React, { useState, useEffect, Fragment } from "react"
import axios from 'axios'
import TextField from '@material-ui/core/TextField'
import Button from '@material-ui/core/Button'

export default function Generation() {
  const [name, setName] = useState('')
  const [generations, setGenerations] = useState([])

  useEffect(() => {
    axios.get('/api/generations')
    .then((response) => {
      setGenerations(response.data)
    })
  }, []);

  const clickHandler = () => {
    if (name) {
      axios.post('/api/generations', { name: name })
      setGenerations((current) => [...current, { name }])
    }
  }

  const submitHandler = (e) => {
    e.preventDefault()
    clickHandler()
    setName('')
  }

  return (
    <Fragment>
      {generations.map((generation, index) => {
        return <p key={index}>{generation.name}</p>
      })}
      <form onSubmit={submitHandler} className="generation-form">
        <TextField id="standard-basic" label="Generation" type="text"  name="name" value={name} onChange={(event) => setName(event.target.value)}/>
        <br /> 
        <Button variant="outlined" style={{ fontSize: '1em', fontWeight: 'bolder' }} onClick={clickHandler}>Submit</Button>
      </form>
    </Fragment>
  )
}