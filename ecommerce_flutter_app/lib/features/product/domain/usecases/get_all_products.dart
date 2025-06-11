import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

//The use case has one job: fetch all products.
class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);
//The call() method is what you run when using the use case.
  Future<List<ProductEntity>> call() async {
    return await repository.getAllProducts();
  }
}
