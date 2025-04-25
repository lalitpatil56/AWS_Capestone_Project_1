import express from 'express';
import AWS from 'aws-sdk';
import cors from 'cors';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const port = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());

app.use(cors({
  origin: '*', // or '*' for dev
}));

// Configure AWS SDK
AWS.config.update({
  region: process.env.AWS_REGION || 'us-east-1',
});

const dynamoDB = new AWS.DynamoDB.DocumentClient();
const TABLE_NAME = process.env.DYNAMODB_TABLE || 'UserTable';

// POST: Add new user
app.post('/users', async (req, res) => {
  const { firstname, lastname, age } = req.body;

  if (!firstname || !lastname || !age) {
    return res.status(400).json({ error: 'Missing required fields' });
  }

  const params = {
    TableName: TABLE_NAME,
    Item: {
      id: `${firstname}-${lastname}-${Date.now()}`,
      firstname,
      lastname,
      age: Number(age),
    },
  };

  try {
    await dynamoDB.put(params).promise();
    res.status(201).json({ message: 'User added successfully' });
  } catch (error) {
    console.error('Error storing user:', error);
    res.status(500).json({ error: 'Could not store user data' });
  }
});

// GET: Fetch all users
app.get('/users', async (req, res) => {
  const params = {
    TableName: TABLE_NAME,
  };

  try {
    const data = await dynamoDB.scan(params).promise();
    res.json(data.Items);
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ error: 'Could not fetch user data' });
  }
});

app.listen(port,'0.0.0.0', () => {
  console.log(`Server running on port ${port}`);
});

