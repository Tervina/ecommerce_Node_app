import 'package:equatable/equatable.dart';
import '../../domain/entities/product_entity.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {} // when nothing has loaded yet.

class ProductLoading extends ProductState {} //while waiting for the API.

//holds list of ProductEntity after successful fetch.
class ProductLoaded extends ProductState {
  final List<ProductEntity> products;

  ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

//shows any error messages.
class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
