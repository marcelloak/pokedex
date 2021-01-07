import React, { useState } from "react"
import TextField from '@material-ui/core/TextField'
import Button from '@material-ui/core/Button'

export default function Login(props) {
  const [password, setPassword] = useState('')

  const onChange = function(event) {
    setPassword(event.target.value)
  }

  const submitHandler = (e) => {
    e.preventDefault()
    clickHandler()
  }

  const clickHandler   = function() {
    if (password === process.env.REACT_APP_PASSWORD) {
      props.setUser(true)
      props.cookies.set('user', true, { path: '/' })
    }
  }

  return (
    <div className="login">
    {!props.user && (
      <form onSubmit={submitHandler} className={`login-form`}>
        <TextField id="standard-basic" label='password' name='password' value={password} onChange={onChange}/>
        <br/>
        <Button variant="outlined" style={{ fontSize: '1em', fontWeight: 'bolder' }} onClick={clickHandler}>Submit</Button>
      </form>
    )}
    </div>
  )
}