const express = require("express");
const router = express.Router();
const Wishlist = require("../models/wishlist");
const Product = require("../models/product");

// ➤ GET user wishlist
// router.get("/:user_id", async (req, res) => {
//   try {
//     const { user_id } = req.params;
//     const wishlist = await Wishlist.findOne({ user_id });

//     if (!wishlist) return res.json([]);

//     // 🔥 Get full product details
//     const products = await Product.find({
//       product_id: { $in: wishlist.items.map(i => i.product_id) }
//     });

//     res.json(products);
//   } catch (err) {
//     res.status(500).json({ message: err.message });
//   }
// });
router.get("/:user_id", async (req, res) => {
  try {
    const { user_id } = req.params;

    const wishlist = await Wishlist.findOne({ user_id }); // ✅ VALID await inside async function

    if (!wishlist) return res.json([]);

    const productIds = wishlist.items.map(i => i.product_id);

    const products = await Product.find({ product_id: { $in: productIds } });

    const merged = wishlist.items.map(item => ({
      product_id: item.product_id,
      added_at: item.added_at,
      product: products
        .find(p => p.product_id === item.product_id)
        ?.toObject(),   // 🟢 Important fix
    }));

    res.json(merged);

  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});



// ➤ ADD item to wishlist
router.post("/add", async (req, res) => {
  try {
    const { user_id, product_id } = req.body;

    let wishlist = await Wishlist.findOne({ user_id });

    if (!wishlist) {
      wishlist = new Wishlist({ user_id, items: [] });
    }

    // Prevent duplicates
    if (!wishlist.items.some(i => i.product_id === product_id)) {
      wishlist.items.push({ product_id });
    }

    await wishlist.save();

    res.json({ message: "Added to wishlist" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// ➤ REMOVE item
router.delete("/remove", async (req, res) => {
  try {
    const { user_id, product_id } = req.body;

    await Wishlist.updateOne(
      { user_id },
      { $pull: { items: { product_id } } }
    );

    res.json({ message: "Removed from wishlist" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// ➤ MOVE ALL TO CART
router.post("/move-all", async (req, res) => {
  try {
    const { user_id } = req.body;

    const wishlist = await Wishlist.findOne({ user_id });
    if (!wishlist) return res.json([]);

    res.json(wishlist.items);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
