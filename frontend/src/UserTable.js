import React, { useEffect, useState } from 'react';

const tableStyle = {
  borderCollapse: 'collapse',
  width: '80%',
  margin: '20px auto',
  boxShadow: '0 2px 8px rgba(0, 0, 0, 0.1)',
};

const thStyle = {
  backgroundColor: '#4CAF50',
  color: 'white',
  padding: '12px',
  textAlign: 'left',
};

const tdStyle = {
  padding: '12px',
  borderBottom: '1px solid #ddd',
};

const rowHoverStyle = {
  backgroundColor: '#f1f1f1',
};

const containerStyle = {
  textAlign: 'center',
  fontFamily: 'Arial, sans-serif',
  padding: '20px',
};

const UsersTable = () => {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    fetch('http://webapp-alb-1886176.us-east-1.elb.amazonaws.com/users')
      .then((response) => response.json())
      .then((data) => setUsers(data))
      .catch((error) => console.error('Error fetching users:', error));
  }, []);

  return (
    <div style={containerStyle}>
      <h2>Users List</h2>
      <table style={tableStyle}>
        <thead>
          <tr>
            <th style={thStyle}>First Name</th>
            <th style={thStyle}>Last Name</th>
            <th style={thStyle}>Age</th>
          </tr>
        </thead>
        <tbody>
          {users.map((user) => (
            <tr
              key={user.id}
              style={{ ...rowHoverStyle, transition: 'background 0.3s' }}
              onMouseOver={(e) => (e.currentTarget.style.backgroundColor = '#f9f9f9')}
              onMouseOut={(e) => (e.currentTarget.style.backgroundColor = '')}
            >
              <td style={tdStyle}>{user.firstname}</td>
              <td style={tdStyle}>{user.lastname}</td>
              <td style={tdStyle}>{user.age}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default UsersTable;