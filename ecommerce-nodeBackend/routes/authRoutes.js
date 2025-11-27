
// const express = require("express");
// const router = express.Router();
// const bcrypt = require("bcryptjs");   // ✅ Add this line
// const jwt = require("jsonwebtoken");
// const { createClient } = require("@supabase/supabase-js");
// const User = require("../models/user.js");

// const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

// // 🟢 SIGNUP
// router.post("/signup", async (req, res) => {
//   const { name, email, password } = req.body;

//   try {
//     // 1️⃣ Create user in Supabase Auth
//     const { data, error } = await supabase.auth.signUp({name, email, password });
//     if (error) return res.status(400).json({ message: error.message });

//     // 2️⃣ Save user profile in MongoDB
//     const newUser = new User({
//       supabase_id: data.user.id,
//       name,
//       email,
//       password,
//       created_at: new Date(),
//     });

//     await newUser.save();

//     res.status(201).json({
//       message: "User signed up successfully",
//       user: newUser,
//     });
//   } catch (err) {
//     res.status(500).json({ message: err.message });
//   }
// });


// //🔑 LOGIN ROUTE
// router.post("/login", async (req, res) => {
//   const { email, password } = req.body;

//   try {
//     // ✅ Try login using Supabase Auth
//     const { data, error } = await supabase.auth.signInWithPassword({
//       email,
//       password,
//     });

//     // ❌ If Supabase returns an error
//     if (error) {
//       return res.status(400).json({ message: error.message });
//     }

//     // ✅ Extract token & user info from Supabase response
//     const token = data.session.access_token; // Supabase access token
//     const user_id = data.user.id;            // Supabase user ID
//     const user_email = data.user.email;

//     // ✅ Respond to frontend
//     return res.status(200).json({
//       message: "Login successful",
//       token,
//       user_id,
//       user_email,
//     });

//   } catch (err) {
//     console.error("Login error:", err);
//     res.status(500).json({ message: "Server error" });
//   }
// });

// // 🟡 Google OAuth Callback - UPDATED VERSION
// router.post("/google-login", async (req, res) => {
//   const { supabase_id, email, name } = req.body;

//   try {
//     // Check if user already exists in MongoDB
//     let user = await User.findOne({ email });
    
//     if (!user) {
//       // Create new user for Google OAuth
//       user = new User({
//         supabase_id,
//         name,
//         email,
//         password: null, // No password for OAuth users
//         created_at: new Date(),
//       });
//       await user.save();
//     } else {
//       // Update supabase_id if user exists but doesn't have it
//       if (!user.supabase_id) {
//         user.supabase_id = supabase_id;
//         await user.save();
//       }
//     }

//     res.status(200).json({ 
//       message: "Google login successful", 
//       user 
//     });
//   } catch (err) {
//     console.error("Google login error:", err);
//     res.status(500).json({ message: err.message });
//   }
// });

// router.post("/reset-password", async (req, res) => {
//   try {
//     const { email, newPassword } = req.body;

//     if (!email || !newPassword) {
//       return res.status(400).json({ message: "Email and password required" });
//     }

//     const hashed = await bcrypt.hash(newPassword, 10);

//     const user = await User.findOneAndUpdate(
//       { email },
//       { password: hashed, resetOtp: null, otpExpires: null },
//       { new: true }
//     );

//     if (!user) {
//       return res.status(404).json({ message: "User not found" });
//     }

//     res.json({ message: "Password updated successfully" });
//   } catch (err) {
//     res.status(500).json({ message: "Server error", error: err.message });
//   }
// });

// module.exports = router; 
// -----------------------------------------------------------------------
// const express = require("express");
// const router = express.Router();
// const bcrypt = require("bcryptjs");
// const { createClient } = require("@supabase/supabase-js");
// const User = require("../models/user");

// const supabase = createClient(
//   process.env.SUPABASE_URL, 
//   process.env.SUPABASE_ANON_KEY
// );

// // 🟢 SIGNUP
// router.post("/signup", async (req, res) => {
//   const { name, email, password } = req.body;

//   try {
//     console.log('📝 Signup attempt:', { name, email });

//     // 1️⃣ Create user in Supabase Auth
//     const { data, error } = await supabase.auth.signUp({ 
//       email, 
//       password,
//       options: {
//         data: { name } // Store name in Supabase metadata
//       }
//     });
    
//     if (error) {
//       console.error('❌ Supabase signup error:', error);
//       return res.status(400).json({ message: error.message });
//     }

//     // 2️⃣ Save user profile in MongoDB
//     const newUser = new User({
//       supabase_id: data.user.id,
//       name,
//       email,
//       password: await bcrypt.hash(password, 10), // Hash password for backup
//       created_at: new Date(),
//     });

//     await newUser.save();

//     console.log('✅ User created:', newUser._id);

//     res.status(201).json({
//       message: "Signup successful!",
//       user: {
//         id: newUser._id,
//         supabase_id: data.user.id,
//         name: newUser.name,
//         email: newUser.email
//       }
//     });
//   } catch (err) {
//     console.error('❌ Signup error:', err);
//     res.status(500).json({ message: err.message });
//   }
// });

// // 🔑 LOGIN
// router.post("/login", async (req, res) => {
//   const { email, password } = req.body;

//   try {
//     console.log('🔐 Login attempt:', email);

//     // ✅ Login using Supabase Auth
//     const { data, error } = await supabase.auth.signInWithPassword({
//       email,
//       password,
//     });

//     if (error) {
//       console.error('❌ Supabase login error:', error);
//       return res.status(400).json({ message: error.message });
//     }

//     // ✅ Get user from MongoDB
//     const user = await User.findOne({ supabase_id: data.user.id });
    
//     if (!user) {
//       return res.status(404).json({ message: "User profile not found" });
//     }

//     console.log('✅ Login successful:', user._id);

//     res.status(200).json({
//       message: "Login successful",
//       token: data.session.access_token,
//       user_id: user._id.toString(), // MongoDB ID for wishlist
//       supabase_id: data.user.id,
//       user: {
//         id: user._id,
//         name: user.name,
//         email: user.email
//       }
//     });
//   } catch (err) {
//     console.error('❌ Login error:', err);
//     res.status(500).json({ message: "Server error" });
//   }
// });

// // 🟡 GOOGLE LOGIN
// router.post("/google-login", async (req, res) => {
//   const { supabase_id, email, name } = req.body;

//   try {
//     console.log('🔐 Google login:', email);

//     // Find or create user in MongoDB
//     let user = await User.findOne({ email });
    
//     if (!user) {
//       user = new User({
//         supabase_id,
//         name,
//         email,
//         password: null, // No password for OAuth
//         created_at: new Date(),
//       });
//       await user.save();
//       console.log('✅ New Google user created:', user._id);
//     } else if (!user.supabase_id) {
//       user.supabase_id = supabase_id;
//       await user.save();
//     }

//     res.status(200).json({ 
//       message: "Google login successful",
//       user_id: user._id.toString(),
//       user: {
//         id: user._id,
//         name: user.name,
//         email: user.email
//       }
//     });
//   } catch (err) {
//     console.error('❌ Google login error:', err);
//     res.status(500).json({ message: err.message });
//   }
// });

// // 🔄 RESET PASSWORD
// router.post("/reset-password", async (req, res) => {
//   try {
//     const { email, newPassword } = req.body;

//     if (!email || !newPassword) {
//       return res.status(400).json({ message: "Email and password required" });
//     }

//     // Update in Supabase
//     const { error } = await supabase.auth.updateUser({
//       password: newPassword
//     });

//     if (error) {
//       return res.status(400).json({ message: error.message });
//     }

//     // Update in MongoDB (backup)
//     const hashed = await bcrypt.hash(newPassword, 10);
//     await User.findOneAndUpdate(
//       { email },
//       { password: hashed }
//     );

//     res.json({ message: "Password updated successfully" });
//   } catch (err) {
//     res.status(500).json({ message: "Server error", error: err.message });
//   }
// });

// module.exports = router;
//-------------------------------------------------------------------------

const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const { createClient } = require('@supabase/supabase-js');
const User = require('../models/user.js');

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || SUPABASE_ANON_KEY;

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

// ---------------- SIGNUP (email/password)
router.post('/signup', async (req, res) => {
  try {
    const { name, email, password } = req.body;
    if (!email || !password) return res.status(400).json({ message: 'Email and password required' });

    // Create in Supabase Auth
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: { data: { name } } // store name in user metadata
    });

    if (error) {
      console.error('Supabase signup error:', error);
      return res.status(400).json({ message: error.message });
    }

    // Save profile in MongoDB
    const hashed = await bcrypt.hash(password, 10);
    const newUser = new User({
      supabase_id: data.user?.id || null,
      name,
      email,
      password: hashed
    });

    await newUser.save();

    res.status(201).json({ message: 'Signup successful!', user: { id: newUser._id, email: newUser.email } });
  } catch (err) {
    console.error('Signup error:', err);
    res.status(500).json({ message: 'Server error', error: err.message });
  }
});

// ---------------- LOGIN (email/password)
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Sign in via Supabase
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password
    });

    if (error) {
      console.error('Supabase login error:', error);
      return res.status(400).json({ message: error.message });
    }

    // Find user in MongoDB by supabase_id or email
    const user = await User.findOne({ supabase_id: data.user?.id }) || await User.findOne({ email });

    if (!user) return res.status(404).json({ message: 'User profile not found' });

    res.status(200).json({
      message: 'Login successful',
      token: data.session?.access_token || null,
      user_id: user._id.toString(),
      supabase_id: data.user?.id || null,
      user: { id: user._id, name: user.name, email: user.email }
    });
  } catch (err) {
    console.error('Login error:', err);
    res.status(500).json({ message: 'Server error' });
  }
});

// ---------------- GOOGLE LOGIN (called by your Flutter app after Supabase OAuth flow)
router.post('/google-login', async (req, res) => {
  try {
    const { supabase_id, email, name } = req.body;
    if (!supabase_id || !email) return res.status(400).json({ message: 'supabase_id and email required' });

    let user = await User.findOne({ supabase_id });

    if (!user) {
      // If no user with supabase_id, try email
      user = await User.findOne({ email });
    }

    if (!user) {
      // Create new user profile
      user = new User({
        supabase_id,
        name,
        email,
        password: null
      });
      await user.save();
      console.log('New OAuth user created:', user._id);
    } else if (!user.supabase_id) {
      // Link supabase_id if existing user by email didn't have it
      user.supabase_id = supabase_id;
      if (name && !user.name) user.name = name;
      await user.save();
    }

    res.status(200).json({
      message: 'Google login successful',
      user_id: user._id.toString(),
      user: { id: user._id, name: user.name, email: user.email }
    });
  } catch (err) {
    console.error('Google login error:', err);
    res.status(500).json({ message: 'Server error', error: err.message });
  }
});

// ---------------- RESET PASSWORD (example using Supabase admin)
router.post('/reset-password', async (req, res) => {
  try {
    const { email, newPassword } = req.body;
    if (!email || !newPassword) return res.status(400).json({ message: 'Email and new password required' });

    // Update via Supabase admin (service role) - find user first
    const { data: users, error: listErr } = await supabase.auth.admin.listUsers();
    if (listErr) {
      console.error('List users error:', listErr);
    }

    // safer: use supabase.auth.admin.updateUserById if you have the user id
    // here we attempt to find by email
    const found = users?.users?.find(u => u.email === email);
    if (!found) return res.status(404).json({ message: 'User not found in Supabase' });

    const { error: updateErr } = await supabase.auth.admin.updateUserById(found.id, {
      password: newPassword
    });

    if (updateErr) {
      console.error('Supabase update password error:', updateErr);
      return res.status(400).json({ message: updateErr.message });
    }

    // Update backup password in MongoDB
    const hashed = await bcrypt.hash(newPassword, 10);
    await User.findOneAndUpdate({ email }, { password: hashed });

    res.json({ message: 'Password updated successfully' });
  } catch (err) {
    console.error('Reset password error:', err);
    res.status(500).json({ message: 'Server error', error: err.message });
  }
});

module.exports = router;
