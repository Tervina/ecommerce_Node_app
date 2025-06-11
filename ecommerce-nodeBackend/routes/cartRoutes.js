const express = require('express');
const router = express.Router();
const Cart = require('../models/cart');



// Get all carts
router.get('/', async (req, res) => {
    try {
      const carts = await Cart.find({});
      res.json(carts);
    } catch (err) {
      res.status(500).json({ message: 'Failed to fetch carts', error: err.message });
    }
  });


// Get user's cart
router.get('/:user_id', async (req, res) => {
  try {
    const cart = await Cart.findOne({ user_id: req.params.user_id });
    res.json(cart || { user_id: req.params.user_id, items: [] });
  } catch (err) {
    res.status(500).json({ message: 'Failed to fetch cart', error: err.message });
  }
});

// Add/update item in cart// Add/update cart item (user_id sent in request body)
router.post('/', async (req, res) => {
  const { user_id, product_id, quantity } = req.body;

  if (!user_id) {
    return res.status(400).json({ message: 'user_id is required' });
  }

  try {
    let cart = await Cart.findOne({ user_id }); // user_id is ObjectId here

    if (!cart) {
      cart = new Cart({ user_id, items: [{ product_id, quantity }] });
    } else {
      const existingItem = cart.items.find(item => item.product_id === product_id);
      if (existingItem) {
        existingItem.quantity += quantity;
      } else {
        cart.items.push({ product_id, quantity });
      }
    }

    cart.updated_at = new Date();
    await cart.save();
    res.json(cart);
} catch (err) {
    console.error("Cart creation failed:", err); // 👈 log full error
    res.status(500).json({ message: 'Failed to update cart', error: err.message });
  }
  
});

module.exports = router;