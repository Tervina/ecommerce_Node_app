const mongoose = require("mongoose");

const wishlistSchema = new mongoose.Schema({
  user_id: { type: String, required: true }, // Supabase user_id
  items: [
    {
      product_id: { type: String, required: true },
      
      added_at: { type: Date, default: Date.now }
    }
  ]
}, { collection: "wishlist" });

module.exports = mongoose.model("Wishlist", wishlistSchema);
