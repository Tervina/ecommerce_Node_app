router.post("/verify-otp", async (req, res) => {
  const { email, otp } = req.body;

  const user = await User.findOne({ email });
  if (!user) return res.status(404).json({ message: "User not found" });

  if (user.resetOtp != otp || Date.now() > user.otpExpires)
    return res.status(400).json({ message: "Invalid or expired OTP" });

  res.json({ message: "OTP verified" });
});
