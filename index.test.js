const request = require('supertest');
const app = require('./index');

describe('API Tests', () => {
  describe('GET /', () => {
    it('should return welcome message', async () => {
      const response = await request(app)
        .get('/')
        .expect('Content-Type', /json/)
        .expect(200);

      expect(response.body).toHaveProperty('message', 'Welcome to the Simple API');
    });
  });

  describe('GET /api/users', () => {
    it('should return list of users', async () => {
      const response = await request(app)
        .get('/api/users')
        .expect('Content-Type', /json/)
        .expect(200);

      expect(Array.isArray(response.body)).toBe(true);
      expect(response.body).toHaveLength(3);
      expect(response.body[0]).toHaveProperty('id');
      expect(response.body[0]).toHaveProperty('name');
      expect(response.body[0]).toHaveProperty('email');
    });
  });

  describe('GET /api/users/:id', () => {
    it('should return user by id', async () => {
      const userId = 123;
      const response = await request(app)
        .get(`/api/users/${userId}`)
        .expect('Content-Type', /json/)
        .expect(200);

      expect(response.body).toHaveProperty('id', userId);
      expect(response.body).toHaveProperty('name', `User ${userId}`);
      expect(response.body).toHaveProperty('email', `user${userId}@example.com`);
    });
  });

  describe('POST /api/users', () => {
    it('should create a new user', async () => {
      const newUser = {
        name: 'Test User',
        email: 'test@example.com'
      };

      const response = await request(app)
        .post('/api/users')
        .send(newUser)
        .expect('Content-Type', /json/)
        .expect(201);

      expect(response.body).toHaveProperty('message', 'User created successfully');
      expect(response.body).toHaveProperty('user');
      expect(response.body.user).toHaveProperty('id');
      expect(response.body.user).toHaveProperty('name', newUser.name);
      expect(response.body.user).toHaveProperty('email', newUser.email);
    });

    it('should handle missing data', async () => {
      const response = await request(app)
        .post('/api/users')
        .send({})
        .expect('Content-Type', /json/)
        .expect(201);

      expect(response.body).toHaveProperty('message', 'User created successfully');
      expect(response.body.user).toHaveProperty('id');
      expect(response.body.user.name).toBeUndefined();
      expect(response.body.user.email).toBeUndefined();
    });
  });

  describe('PUT /api/users/:id', () => {
    it('should update a user', async () => {
      const userId = 456;
      const updatedUser = {
        name: 'Updated User',
        email: 'updated@example.com'
      };

      const response = await request(app)
        .put(`/api/users/${userId}`)
        .send(updatedUser)
        .expect('Content-Type', /json/)
        .expect(200);

      expect(response.body).toHaveProperty('message', 'User updated successfully');
      expect(response.body).toHaveProperty('user');
      expect(response.body.user).toHaveProperty('id', userId);
      expect(response.body.user).toHaveProperty('name', updatedUser.name);
      expect(response.body.user).toHaveProperty('email', updatedUser.email);
    });
  });

  describe('DELETE /api/users/:id', () => {
    it('should delete a user', async () => {
      const userId = 789;
      const response = await request(app)
        .delete(`/api/users/${userId}`)
        .expect('Content-Type', /json/)
        .expect(200);

      expect(response.body).toHaveProperty('message', `User ${userId} deleted successfully`);
    });
  });

  describe('404 Handler', () => {
    it('should return 404 for unknown routes', async () => {
      await request(app)
        .get('/api/unknown')
        .expect(404);
    });
  });
});