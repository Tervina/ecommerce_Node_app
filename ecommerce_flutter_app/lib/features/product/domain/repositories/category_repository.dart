import '../entities/product_entity.dart';

abstract class CategoryRepository {
  Future<List<ProductEntity>> getProductsByCategory(String categoryName);
}
