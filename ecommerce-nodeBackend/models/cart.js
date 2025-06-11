const mongoose = require('mongoose');

const cartSchema = new mongoose.Schema({
  user_id: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  items: [
    {
      product_id: { type: String, required: true },
      quantity: { type: Number, default: 1 },
    }
  ],
  updated_at: { type: Date, default: Date.now },
}, { collection: 'carts' });

module.exports = mongoose.model('Cart', cartSchema);


