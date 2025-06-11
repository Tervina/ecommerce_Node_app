const express = require('express');
const router = express.Router();
const Product = require('../models/product');

router.get('/', async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});


router.get('/search', async (req, res) => {
  const { category, name } = req.query;
  console.log('Received Query:', req.query); // 👈 log this
  let filter = {};
  if (category) filter.category = { $regex: category, $options: 'i' };
  if (name) filter.product_name = { $regex: name, $options: 'i' };

  try {
    const products = await Product.find(filter);
    res.json(products);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Search failed' });
  }
});


// GET /products/:id => Fetch product by product_id
router.get('/:id', async (req, res) => {
    const { id } = req.params;
    console.log('Product ID:', id);  // Log the ID you're receiving in the route
    try {
        const product = await Product.findOne({ product_id: id });
        if (!product) {
            return res.status(404).json({ message: 'Product not found' });
        }
        res.json(product);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});


module.exports = router;
