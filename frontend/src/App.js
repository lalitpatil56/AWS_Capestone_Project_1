import React, { useState } from 'react';
import './App.css';
import UsersTable from './UserTable';

function App() {
  const [formData, setFormData] = useState({
    firstname: '',
    lastname: '',
    age: ''
  });

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
  
    const data = { firstname:formData.firstname, lastname:formData.lastname, age:formData.age };
        console.log(data)
    try {
      const response = await fetch('http://webapp-alb-1886176.us-east-1.elb.amazonaws.com/users', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
      });
  
      const result = await response.json();
      console.log('Result:', result);
    } catch (error) {
      console.error('Error:', error);
    }
  };

  return (
    <div className="App">
      <h1>User Form</h1>
      <form onSubmit={handleSubmit}>
        <label>
          First Name:
          <input type="text" name="firstname" value={formData.firstname} onChange={handleChange} required />
        </label>
        <br />
        <label>
          Last Name:
          <input type="text" name="lastname" value={formData.lastname} onChange={handleChange} required />
        </label>
        <br />
        <label>
          Age:
          <input type="number" name="age" value={formData.age} onChange={handleChange} required />
        </label>
        <br />
        <button type="submit">Submit</button>
      </form>
      <UsersTable/>
    </div>
  );
}

export default App;


