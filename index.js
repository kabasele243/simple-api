const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
  res.json({ message: 'Welcome to the Simple API' });
});

app.get('/api/users', (req, res) => {
  const users = [
    { id: 1, name: 'John Doe', email: 'john@example.com' },
    { id: 2, name: 'Jane Smith', email: 'jane@example.com' },
    { id: 3, name: 'Bob Johnson', email: 'bob@example.com' }
  ];
  res.json(users);
});

app.get('/api/users/:id', (req, res) => {
  const userId = parseInt(req.params.id);
  const user = {
    id: userId,
    name: `User ${userId}`,
    email: `user${userId}@example.com`
  };
  res.json(user);
});

app.post('/api/users', (req, res) => {
  const newUser = {
    id: Date.now(),
    name: req.body.name,
    email: req.body.email
  };
  res.status(201).json({
    message: 'User created successfully',
    user: newUser
  });
});

app.put('/api/users/:id', (req, res) => {
  const userId = parseInt(req.params.id);
  const updatedUser = {
    id: userId,
    name: req.body.name,
    email: req.body.email
  };
  res.json({
    message: 'User updated successfully',
    user: updatedUser
  });
});

app.delete('/api/users/:id', (req, res) => {
  const userId = parseInt(req.params.id);
  res.json({
    message: `User ${userId} deleted successfully`
  });
});

if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
  });
}

module.exports = app;