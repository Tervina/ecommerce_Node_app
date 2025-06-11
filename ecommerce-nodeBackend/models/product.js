// models i want from my database 

const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
  product_id: String,
  product_name: String,
  category: String,
  discounted_price: String,
  actual_price: String,
  discount_percentage: String,
  rating: Number,
  rating_count: String,
  about_product: String,
  user_id: String,
  user_name: String,
  review_id: String,
  review_title: String,
  review_content: String,
  img_link: String,
  product_link: String,
}, { collection: 'ecommerceDB' }); // 👈 THIS IS IMPORTANT

module.exports = mongoose.model('Product', productSchema);
