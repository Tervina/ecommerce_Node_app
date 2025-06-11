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
              price: model.price,
              description: model.description,
              imageUrl: model.imageUrl,
            ))
        .toList(); //Maps each ProductModel into a ProductEntity.
  }
}
