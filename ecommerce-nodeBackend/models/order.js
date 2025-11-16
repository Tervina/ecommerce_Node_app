const mongoose = require("mongoose");

const OrderSchema = new mongoose.Schema({
  user_id: { type: String, default: "" },
  items: [
    {
      product_id: String,
      product_name: String,
      quantity: Number,
      price: Number,
      status: {
          type: String,
          enum: ["pending", "shipped", "delivered", "cancelled"],
          default: "pending",
        },
    },
  ],
  billingDetails: {
        fullName: { type: String, required: true }, // 👈 ADD THIS
        streetAddress: { type: String, required: true }, // 👈 ADD THIS
        city: { type: String, required: true }, // 👈 ADD THIS
        phone: { type: String, required: true }, // 👈 ADD THIS
        email: { type: String, required: true }, // 👈 ADD THIS
    },
    paymentMethod: { type: String, enum: ["Bank", "Cash on delivery"], required: true },
    totalAmount: { type: Number, required: true },
  created_at: { type: Date, default: Date.now }
},{ collection: 'Order' });

module.exports = mongoose.model("Order", OrderSchema);
