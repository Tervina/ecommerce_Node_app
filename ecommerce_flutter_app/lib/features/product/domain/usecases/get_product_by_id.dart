import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductById {
  final ProductRepository repository;

  GetProductById(this.repository);

  Future<ProductEntity> call(String id) async {
    return await repository.getProductById(id);
  }
}
