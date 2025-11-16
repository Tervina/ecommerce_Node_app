// request-reset.js
const express = require("express");
const router = express.Router();
const User = require("../models/User");
const supabase = require("../config/supabaseClient");

router.post("/request-reset", async (req, res) => {
  const { email } = req.body;

  const user = await User.findOne({ email });
  if (!user) return res.status(404).json({ message: "User not found" });

  const otp = Math.floor(100000 + Math.random() * 900000); // 6-digit OTP
  user.resetOtp = otp;
  user.otpExpires = Date.now() + 15 * 60 * 1000; // 15 mins
  await user.save();

  // Send OTP using Supabase email
  await supabase.auth.admin.sendEmail({
    to: email,
    subject: "Password Reset OTP",
    html: `<h2>Your OTP is ${otp}</h2>`
  });

  res.json({ message: "OTP sent to email" });
});

module.exports = router;
