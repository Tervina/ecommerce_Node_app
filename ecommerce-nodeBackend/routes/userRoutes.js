// const express = require('express');
// const router = express.Router();
// const User = require('../models/user');

// // Create new user (POST /api/users)
// router.post('/', async (req, res) => {
//     const { name, email, password } = req.body;
//     try {
//       if (!name || !email || !password) {
//         return res.status(400).json({ message: "Name, email and password are required" });
//       }
//       const newUser = new User({ name, email, password });
//       await newUser.save();
//       res.status(201).json(newUser);
//     } catch (err) {
//       console.error('Error creating user:', err); // log full error to console
//       res.status(500).json({ message: 'Failed to create user', error: err.message });
//     }
//   });
  

// // Get all users (GET /api/users)
// router.get('/', async (req, res) => {
//   try {
//     const users = await User.find({});
//     res.json(users);
//   } catch (err) {
//     res.status(500).json({ message: 'Error fetching users', error: err.message });
//   }
// });

// // **Export the router here**
// module.exports = router;
const express = require('express');
const router = express.Router();
const User = require('../models/user');
const bcrypt = require('bcryptjs'); // Install: npm install bcryptjs
const jwt = require('jsonwebtoken'); // Install: npm install jsonwebtoken

// 🟢 SIGNUP ROUTE
router.post('/signup', async (req, res) => {
  try {
    const { name, email, password } = req.body;

    // Validate input
    if (!name || !email || !password) {
      return res.status(400).json({ message: "All fields are required" });
    }

    // Check if user already exists
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: "Email already registered" });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create new user
    const newUser = new User({
      name,
      email,
      password: hashedPassword
    });

    await newUser.save();

    res.status(201).json({
      message: "Account created successfully! Please log in.",
      user: {
        id: newUser._id,
        name: newUser.name,
        email: newUser.email
      }
    });

  } catch (error) {
    console.error('Signup error:', error);
    res.status(500).json({ message: "Signup failed", error: error.message });
  }
});

// 🟢 LOGIN ROUTE
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Validate input
    if (!email || !password) {
      return res.status(400).json({ message: "Email and password are required" });
    }

    // Find user
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(401).json({ message: "Invalid email or password" });
    }

    // Check password
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({ message: "Invalid email or password" });
    }

    // Generate JWT token
    const token = jwt.sign(
      { userId: user._id, email: user.email },
      process.env.JWT_SECRET || 'your-secret-key', // Add this to .env
      { expiresIn: '7d' }
    );

    res.status(200).json({
      message: "Login successful",
      token: token,
      user_id: user._id.toString(), // Important: convert to string
      user: {
        id: user._id,
        name: user.name,
        email: user.email
      }
    });

  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ message: "Login failed", error: error.message });
  }
});

// 🟡 GOOGLE LOGIN ROUTE
router.post('/google-login', async (req, res) => {
  try {
    const { supabase_id, email, name } = req.body;

    // Find or create user
    let user = await User.findOne({ email });

    if (!user) {
      // Create new user for Google login
      user = new User({
        name,
        email,
        password: await bcrypt.hash(supabase_id, 10) // Use supabase_id as password
      });
      await user.save();
    }

    // Generate token
    const token = jwt.sign(
      { userId: user._id, email: user.email },
      process.env.JWT_SECRET || 'your-secret-key',
      { expiresIn: '7d' }
    );

    res.status(200).json({
      message: "Google login successful",
      token: token,
      user_id: user._id.toString(),
      user: {
        id: user._id,
        name: user.name,
        email: user.email
      }
    });

  } catch (error) {
    console.error('Google login error:', error);
    res.status(500).json({ message: "Google login failed", error: error.message });
  }
});

module.exports = router;