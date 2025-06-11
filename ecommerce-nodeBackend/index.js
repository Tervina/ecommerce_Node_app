const express = require('express'); //Imports the Express framework, which simplifies building APIs and web servers.
const cors = require('cors'); //CORS allows your frontend (like Flutter Web) to make API calls to your backend without browser security issues.
const connectDB = require('./config/db'); //Imports your database connection function from config/db.js
const productRoutes = require('./routes/productRoutes'); //Imports your product-related API routes.
const userRoutes = require('./routes/userRoutes');
const cartRoutes = require('./routes/cartRoutes');
require('dotenv').config(); //Initializes dotenv so it can load .env file contents into process.env.


const app = express(); //Creates an Express app (your backend server).



// Middleware
app.use(cors()); // Enables CORS to allow your frontend (hosted on a different port or domain) to access this backend.


app.use(express.json()); //Tells Express to automatically parse incoming JSON data (like from a POST request body).



// Connect DB
connectDB(); // Calls the function that connects your backend to MongoDB.



// Routes
app.use('/api/products', productRoutes); //When a request comes in to /api/products, use the productRoutes file to handle it.

app.use('/api/users', userRoutes);

app.use('/api/cart', cartRoutes);



// Start Server
const PORT = process.env.PORT || 5000; //Sets the port number to either the one in .env (e.g., PORT=4000) or defaults to 5000.


app.listen(PORT, () => console.log(`Server running on port ${PORT} 🚀`)); // When the server is running, it prints:

