const { getAllProducts, createProduct } = require('../usecases/productUseCases');

const getProducts = async (req, res) => {
  const products = await getAllProducts();
  res.json(products);
};

const addProduct = async (req, res) => {
  const newProduct = await createProduct(req.body);
  res.status(201).json(newProduct);
};

module.exports = {
  getProducts,
  addProduct
};
