import React, { useState } from "react"
import axios from 'axios'
import TextField from '@material-ui/core/TextField'
import Button from '@material-ui/core/Button'

export default function Generation() {
  const [name, setName] = useState("")

  const clickHandler = () => {
    if (name) {
      axios.post('/api/generations', { name: name })
    }
  }

  const submitHandler = (e) => {
    e.preventDefault();
  }

  return (
    <form onSubmit={submitHandler} className="generation-form">
      <TextField id="standard-basic" label="Generation" type="text"  name="name" value={name} onChange={(event) => setName(event.target.value)}/>
      <br /> 
      <Button variant="outlined" style={{ fontSize: '1em', fontWeight: 'bolder' }} onClick={clickHandler}>Submit</Button>
    </form>
  )
}