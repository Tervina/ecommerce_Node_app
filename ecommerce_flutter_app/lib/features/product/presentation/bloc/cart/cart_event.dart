import 'package:equatable/equatable.dart';
import '../../../domain/entities/product_entity.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {
  const LoadCart();
}

class AddToCart extends CartEvent {
  final ProductEntity product;
  final int quantity;
  const AddToCart({required this.product, this.quantity = 1});

  @override
  List<Object?> get props => [product, quantity];
}

class RemoveFromCart extends CartEvent {
  final String productId;
  const RemoveFromCart(this.productId);

  @override
  List<Object?> get props => [productId];
}

class UpdateQuantity extends CartEvent {
  final String productId;
  final int newQuantity;
  const UpdateQuantity({required this.productId, required this.newQuantity});

  @override
  List<Object?> get props => [productId, newQuantity];
}

class ClearCart extends CartEvent {
  const ClearCart();
}
