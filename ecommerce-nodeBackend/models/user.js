const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
//   user_id: { type: String, unique: true }, // e.g., UUID or custom ID
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true }, // You should hash this!
  created_at: { type: Date, default: Date.now }
}, { collection: 'users' }); // 👈 sets MongoDB collection name to "users"

module.exports = mongoose.model('User', userSchema);
