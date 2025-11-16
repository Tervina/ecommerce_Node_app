import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_flutter_app/features/product/domain/repositories/category_repository.dart';
import 'package:ecommerce_flutter_app/features/product/data/datasources/category_remote_data_source.dart';
import 'package:ecommerce_flutter_app/features/product/data/models/product_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryName) async {
    final response = await remoteDataSource.getProductsByCategory(categoryName);
    final List data = response.data;

    final List<ProductModel> models =
        data.map((json) => ProductModel.fromJson(json)).toList();

    return models
        .map((model) => ProductEntity(
              id: model.id,
              name: model.name,
              price: model.price,
              discountedPrice: model.discountedPrice,
              description: model.description,
              imageUrl: model.imageUrl,
              discountPercentage: model.discountPercentage,
              category: model.category,
              rating: model.rating,
            ))
        .toList();
  }
}
