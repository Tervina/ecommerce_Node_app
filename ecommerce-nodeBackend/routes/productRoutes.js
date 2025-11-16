const express = require('express');
const router = express.Router();
const Product = require('../models/product');
// import {
//   getAllProducts,
//   getProductById,
// } from "../controllers/productController.js";
// import Product from "../models/productModel.js";


router.get('/', async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.get('/search', async (req, res) => {
  try {
    const query = req.query.name; // Flutter sends ?name=...

    if (!query) {
      // Return empty array if no query provided
      return res.status(200).json([]);
    }

    const products = await Product.find({
      product_name: { $regex: query, $options: 'i' },
    });

    // Always return a list (even if empty)
    return res.status(200).json(products);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error', error: error.message });
  }
});


// ✅ Search products by name
// router.get('/search', async (req, res) => {
//   try {
//     const query = req.query.name; // Flutter sends ?name=...
//     if (!query) {
//       return res.status(400).json({ message: 'Query parameter "name" is required' });
//     }

//     const products = await Product.find({
//       product_name: { $regex: query, $options: 'i' },
//     });

//     if (products.length === 0) {
//       return res.status(404).json({ message: 'No products found' });
//     }

//     res.json(products);
//   } catch (error) {
//     res.status(500).json({ message: 'Server error', error: error.message });
//   }
// });



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


router.get("/category/:categoryName", async (req, res) => {
  try {
    const categoryName = req.params.categoryName;

    // Find products where category OR product_name matches (case-insensitive)
    const products = await Product.find({
      $or: [
        { category: { $regex: categoryName, $options: "i" } },
        { product_name: { $regex: categoryName, $options: "i" } }
      ]
    });

    if (products.length === 0) {
      return res.status(404).json({ message: "No products found" });
    }

    res.json(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


module.exports = router;