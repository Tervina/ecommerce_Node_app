const express = require("express");
const router = express.Router();
const sendEmail = require("../utils/emailSender.js"); // same email function you use for orders

router.post("/", async (req, res) => {
  try {
    const { name, email, phone, message } = req.body;

    if (!name || !email || !message) {
      return res.status(400).json({
        error: "Name, email, and message fields are required.",
      });
    }

    const htmlContent = `
      <div style="font-family: Arial, sans-serif; padding: 15px;">
        <h2 style="color:#ff4d4d;">📩 New Contact Message</h2>

        <p><strong>Name:</strong> ${name}</p>
        <p><strong>Email:</strong> ${email}</p>
        <p><strong>Phone:</strong> ${phone || "Not provided"}</p>

        <h3 style="margin-top: 20px;">Message:</h3>
        <p style="white-space: pre-line; background:#f9f9f9; padding:10px; border-radius:5px;">
          ${message}
        </p>

        <hr/>
        <p>This email was sent from the contact form on your website.</p>
      </div>
    `;

    // Send to your support email
    await sendEmail(
      "tervina.samir012@gmail.com"
,
      `Contact Message from ${name}`,
      htmlContent
    );

    res.status(200).json({ message: "Message sent successfully!" });

  } catch (err) {
    console.error("❌ Error sending contact email:", err);
    res.status(500).json({ error: "Failed to send contact message" });
  }
});

module.exports = router;
