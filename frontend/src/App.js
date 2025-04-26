import React, { useState } from 'react';
import './App.css';
import UsersTable from './UserTable';

function App() {
  const [formData, setFormData] = useState({
    firstname: '',
    lastname: '',
    age: ''
  });


  const [refreshKey, setRefreshKey] = useState(0); // Key to trigger refresh
  const [successMessage, setSuccessMessage] = useState('');

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const data = { firstname: formData.firstname, lastname: formData.lastname, age: formData.age };
    console.log(data);
    try {
      const response = await fetch('http://webapp-alb-1886176.us-east-1.elb.amazonaws.com/users', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
      });

      const result = await response.json();
      console.log('Result:', result);

      setFormData({ firstname: '', lastname: '', age: '' }); // Clear form
      setRefreshKey(prev => prev + 1); // Trigger table refresh
      setSuccessMessage('User added successfully!');
      setTimeout(() => setSuccessMessage(''), 3000); // Clear message after 3 sec

    } catch (error) {
      console.error('Error:', error);
      setSuccessMessage('Error adding user.');
    }
  };

  const layoutStyle = {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    padding: '30px',
    fontFamily: 'Arial, sans-serif',
    gap: '30px',
  };

  const formContainerStyle = {
    flex: '1',
    padding: '20px',
    boxShadow: '0 0 10px rgba(0,0,0,0.1)',
    borderRadius: '10px',
    backgroundColor: '#f9f9f9',
    display: 'flex', 
    alignItems: 'center'
  };

  const inputStyle = {
    width: '100%',
    padding: '10px',
    marginBottom: '15px',
    border: '1px solid #ccc',
    borderRadius: '4px',
    fontSize: '16px',
  };

  const labelStyle = {
    marginBottom: '5px',
    fontWeight: 'bold'
  };

  const buttonStyle = {
    backgroundColor: '#4CAF50',
    color: 'white',
    padding: '12px 20px',
    border: 'none',
    borderRadius: '5px',
    cursor: 'pointer',
    fontSize: '16px',
  };

  return (
    <div className="App">
      <div style={layoutStyle}>
        <div style={formContainerStyle}>
          <h2>User Form</h2>
          {successMessage && <div style={{ color: 'green', marginBottom: '10px' }}>{successMessage}</div>}
          <form onSubmit={handleSubmit}>
            <label style={labelStyle}>First Name:</label>
            <input type="text" name="firstname" value={formData.firstname} onChange={handleChange} required style={inputStyle} />

            <label style={labelStyle}>Last Name:</label>
            <input type="text" name="lastname" value={formData.lastname} onChange={handleChange} required style={inputStyle} />

            <label style={labelStyle}>Age:</label>
            <input type="number" name="age" value={formData.age} onChange={handleChange} required style={inputStyle} />

            <button type="submit" style={buttonStyle}>Submit</button>
          </form>
        </div>

        <div style={{ flex: '1', padding: '20px' }}>
          <UsersTable refreshKey={refreshKey}/>
        </div>
      </div>
    </div>
  );
}

export default App;