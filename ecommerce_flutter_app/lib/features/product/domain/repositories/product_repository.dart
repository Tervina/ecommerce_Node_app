/**This says: “Any product repository must provide a getAllProducts() method.”

The ProductEntity is a clean, backend-independent representation of a product (we’ll create it soon).*/

import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>>
      getAllProducts(); // It returns a Future<List<ProductEntity>> = async list of products./
}
