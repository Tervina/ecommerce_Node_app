import 'dart:convert'; // This imports Dart’s built-in convert library like jsonDecode and jsonEncode .
import 'package:http/http.dart'
    as http; // This imports the http package, which helps you make network requests like GET, POST,
import '../models/product_model.dart'; // This imports the ProductModel so we can convert the backend JSON response into Dart objects.

//This is an abstract class — it only defines what should be done, not how.
abstract class ProductRemoteDataSource {
  Future<List<ProductModel>>
      getAllProducts(); // Future<List<ProductModel>> getAllProducts() means: "We promise to return a future list of product models".
}

//This is where we’ll actually write the working code to fetch products.
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client
      client; // client is like your browser or Postman. It’s used to send HTTP requests

  ProductRemoteDataSourceImpl(
      {required this.client}); // abstract class It says: “Whoever creates this object must provide an http.Client”.

//This is the real implementation of the abstract method we defined earlier.
//It’s async because it will wait for a network response.

  @override
  Future<List<ProductModel>> getAllProducts() async {
    //We make an HTTP GET request to your backend (/api/products).

    final response = await client.get(
      Uri.parse(
          'http://localhost:5000/api/products'), // Or http://10.0.2.2 if on Android emulator
      headers: {'Content-Type': 'application/json'},
    );
    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response
          .body); //jsonDecode takes the JSON string from the server and turns it into a Dart list of maps.

      return jsonList.map((e) => ProductModel.fromJson(e)).toList();
      /*map((e) => ...) loops over each product (each e is one map).

      It turns each JSON product into a ProductModel using its fromJson constructor.

      .toList() converts the final result back to a real Dart list.*/
    } else {
      throw Exception(
          'Failed to load products'); //If the server didn’t respond with 200, we throw an error.
    }
  }
}
