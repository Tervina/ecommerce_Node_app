import 'package:ecommerce_flutter_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductEntity product;
  final List<ProductEntity> relatedProducts;

  final int quantity;

  ProductDetailsLoaded(
      {required this.product,
      required this.quantity,
      required this.relatedProducts});
}

class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError(this.message);
}
