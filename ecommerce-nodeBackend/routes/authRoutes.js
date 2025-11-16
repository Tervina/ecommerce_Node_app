// const express = require("express");
// const router = express.Router();
// const { createClient } = require("@supabase/supabase-js");

// const supabase = createClient(
//   process.env.SUPABASE_URL,
//   process.env.SUPABASE_ANON_KEY
// );

// // ✅ Sign Up
// router.post("/signup", async (req, res) => {
//   const { email, password } = req.body;

//   const { data, error } = await supabase.auth.signUp({ name,email, password });

//   if (error) return res.status(400).json({ error: error.message });
//   res.json({ message: "User created successfully", data });
// });

// // ✅ Login
// router.post("/login", async (req, res) => {
//   const { email, password } = req.body;

//   const { data, error } = await supabase.auth.signInWithPassword({
//     email,
//     password,
//   });

//   if (error) return res.status(400).json({ error: error.message });
//   res.json({ message: "Login successful", data });
// });

// module.exports = router;


// // const express = require('express');
// // const router = express.Router();
// // const { signup, login, getAllUsers } = require('../controllers/authController');
// // const protect = require('../middlewares/authMiddleware');

// // // Routes
// // router.post('/signup', signup);
// // router.post('/login', login);
// // router.get('/users', protect, getAllUsers); // protected route

// // module.exports = router;
// routes/authRoutes.js

// const express = require("express");
// const router = express.Router();
// const { signup, login, getAllUsers } = require("../controllers/authController");

// // 🟢 MongoDB + JWT routes
// router.post("/signup", signup);
// router.post("/login", login);
// router.get("/users", getAllUsers);

// module.exports = router;
// routes/auth.js
const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");   // ✅ Add this line
const jwt = require("jsonwebtoken");
const { createClient } = require("@supabase/supabase-js");
const User = require("../models/user.js");

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

// 🟢 SIGNUP
router.post("/signup", async (req, res) => {
  const { name, email, password } = req.body;

  try {
    // 1️⃣ Create user in Supabase Auth
    const { data, error } = await supabase.auth.signUp({name, email, password });
    if (error) return res.status(400).json({ message: error.message });

    // 2️⃣ Save user profile in MongoDB
    const newUser = new User({
      supabase_id: data.user.id,
      name,
      email,
      password,
      created_at: new Date(),
    });

    await newUser.save();

    res.status(201).json({
      message: "User signed up successfully",
      user: newUser,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// router.post("/login", async (req, res) => {
//   const { email, password } = req.body;
//   try {
//     const { data, error } = await supabase.auth.signInWithPassword({
//       email,
//       password,
//     });
//     if (error) {
//       return res.status(400).json({ message: error.message });
//     }
    
//     // res.json({
//     //   message: "Login successful!",
//     //   session: data.session,
//     // });
//     res.json({
//   token,
//   user_id: user._id,
//   message: "Login successful"
// });

//   } catch (err) {
//     res.status(400).json({ message: err.message });
//   }
// });
//🔑 LOGIN ROUTE
router.post("/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    // ✅ Try login using Supabase Auth
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });

    // ❌ If Supabase returns an error
    if (error) {
      return res.status(400).json({ message: error.message });
    }

    // ✅ Extract token & user info from Supabase response
    const token = data.session.access_token; // Supabase access token
    const user_id = data.user.id;            // Supabase user ID
    const user_email = data.user.email;

    // ✅ Respond to frontend
    return res.status(200).json({
      message: "Login successful",
      token,
      user_id,
      user_email,
    });

  } catch (err) {
    console.error("Login error:", err);
    res.status(500).json({ message: "Server error" });
  }
});

// 🟡 Google OAuth Callback - UPDATED VERSION
router.post("/google-login", async (req, res) => {
  const { supabase_id, email, name } = req.body;

  try {
    // Check if user already exists in MongoDB
    let user = await User.findOne({ email });
    
    if (!user) {
      // Create new user for Google OAuth
      user = new User({
        supabase_id,
        name,
        email,
        password: null, // No password for OAuth users
        created_at: new Date(),
      });
      await user.save();
    } else {
      // Update supabase_id if user exists but doesn't have it
      if (!user.supabase_id) {
        user.supabase_id = supabase_id;
        await user.save();
      }
    }

    res.status(200).json({ 
      message: "Google login successful", 
      user 
    });
  } catch (err) {
    console.error("Google login error:", err);
    res.status(500).json({ message: err.message });
  }
});

router.post("/reset-password", async (req, res) => {
  try {
    const { email, newPassword } = req.body;

    if (!email || !newPassword) {
      return res.status(400).json({ message: "Email and password required" });
    }

    const hashed = await bcrypt.hash(newPassword, 10);

    const user = await User.findOneAndUpdate(
      { email },
      { password: hashed, resetOtp: null, otpExpires: null },
      { new: true }
    );

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.json({ message: "Password updated successfully" });
  } catch (err) {
    res.status(500).json({ message: "Server error", error: err.message });
  }
});

module.exports = router; 