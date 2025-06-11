const express = require('express');
const router = express.Router();
const User = require('../models/user');

// Create new user (POST /api/users)
router.post('/', async (req, res) => {
    const { name, email, password } = req.body;
    try {
      if (!name || !email || !password) {
        return res.status(400).json({ message: "Name, email and password are required" });
      }
      const newUser = new User({ name, email, password });
      await newUser.save();
      res.status(201).json(newUser);
    } catch (err) {
      console.error('Error creating user:', err); // log full error to console
      res.status(500).json({ message: 'Failed to create user', error: err.message });
    }
  });
  

// Get all users (GET /api/users)
router.get('/', async (req, res) => {
  try {
    const users = await User.find({});
    res.json(users);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching users', error: err.message });
  }
});

// **Export the router here**
module.exports = router;
