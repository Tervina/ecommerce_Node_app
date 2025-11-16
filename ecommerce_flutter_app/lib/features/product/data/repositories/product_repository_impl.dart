import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_flutter_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_flutter_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_flutter_app/features/product/data/models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource
      remoteDataSource; //We use the remote data source to fetch data from the API.

  ProductRepositoryImpl(
      {required this.remoteDataSource}); //We pass in the data source when creating this object.

  @override
  //It returns a list of clean ProductEntity objects.

  Future<List<ProductEntity>> getAllProducts() async {
    final List<ProductModel> models = await remoteDataSource
        .getAllProducts(); //Calls the API through the remote data source.Gets a list of ProductModel
    return models
        .map((model) => ProductEntity(
              id: model.id,
              name: model.name,
              price: model.price, // use actual_price for price field
              discountedPrice: model.discountedPrice,
              description: model.description,
              imageUrl: model.imageUrl,
              discountPercentage: model.discountPercentage,
              category: model.category,
              rating: model.rating,
            ))
        .toList(); //Maps each ProductModel into a ProductEntity.
  }

  @override
  Future<ProductEntity> getProductById(String id) async {
    final product = await remoteDataSource.getProductById(id);
    return product as ProductEntity; // Explicit cast
  }
}
