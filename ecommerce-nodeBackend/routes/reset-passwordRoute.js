const bcrypt = require("bcryptjs");

router.post("/reset-password", async (req, res) => {
  const { email, newPassword } = req.body;

  const hashed = await bcrypt.hash(newPassword, 10);

  await User.findOneAndUpdate(
    { email },
    { password: hashed, resetOtp: null, otpExpires: null }
  );

  res.json({ message: "Password updated successfully" });
});
