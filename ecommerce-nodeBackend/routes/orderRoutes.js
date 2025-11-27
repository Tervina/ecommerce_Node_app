
const express = require("express");
const router = express.Router();
const Order = require("../models/order.js");
const Product = require("../models/product.js");
const sendOrderEmail = require("../utils/emailSender.js");

router.post("/", async (req, res) => {
  try {
    let { user_id, items, billingDetails, paymentMethod, totalAmount } = req.body;
    const userIdValue = user_id || "guest";
    totalAmount = Number(totalAmount);

    if (!items || items.length === 0) {
      return res.status(400).json({ error: "Order must contain at least one item." });
    }

    // Check stock availability
    for (const item of items) {
      const product = await Product.findOne({ product_id: item.product_id });
      if (!product) {
        return res.status(404).json({ error: `Product not found: ${item.product_name}` });
      }
      if (product.stock < item.quantity) {
        return res.status(400).json({ error: `Not enough stock for ${product.product_name}` });
      }
    }

    // Update stock
    for (const item of items) {
      await Product.updateOne(
        { product_id: item.product_id },
        { $inc: { stock: -item.quantity } }
      );
    }

    // Create new order
    const newOrder = new Order({
      user_id: userIdValue,
      items,
      billingDetails,
      paymentMethod,
      totalAmount,
    });

    await newOrder.save();

    // Build email HTML
    const emailHTML = `
      <h2>Thank you for your order!</h2>
      <p>Hello ${billingDetails.fullName},</p>
      <p>We received your order and it is now being processed.</p>
      <h3>Order Details</h3>
      <ul>
        ${items.map(i => `<li>${i.product_name} × ${i.quantity} — $${i.price}</li>`).join("")}
      </ul>
      <h3>Total: $${totalAmount}</h3>
      <p>Payment method: ${paymentMethod}</p>
    `;

    try {
      await sendOrderEmail(
        billingDetails.email,
        "Your Order Confirmation",
        emailHTML
      );
    } catch (emailErr) {
      console.error("❌ Failed to send order confirmation email:", emailErr);
    }

    res.status(201).json({
      message: "✅ Order placed successfully and email sent",
      order: newOrder
    });

  } catch (err) {
    console.error("❌ Failed to place order:", err);
    res.status(500).json({ message: "❌ Failed to place order", error: err.message });
  }
});

module.exports = router;
