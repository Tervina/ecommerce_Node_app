import 'package:equatable/equatable.dart';
import '../../../domain/entities/product_entity.dart';

class CartItem extends Equatable {
  final ProductEntity product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({ProductEntity? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<CartItem> items;
  const CartLoaded({this.items = const []});

  double get subtotal => items.fold(
      0.0, (sum, item) => sum + (item.product.price * item.quantity));

  @override
  List<Object?> get props => [items];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
