// methods used to access database in different ways 

const Product = require('../models/product');

const getAllProducts = async () => {
  return await Product.find();
};

const createProduct = async (productData) => {
  const newProduct = new Product(productData);
  return await newProduct.save();
};

module.exports = {
  getAllProducts,
  createProduct
};
