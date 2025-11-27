import 'package:ecommerce_flutter_app/features/product/data/models/wishlist_item_model.dart';
import 'package:equatable/equatable.dart';

abstract class WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<WishlistItem> items;
  WishlistLoaded(this.items);
}

class WishlistError extends WishlistState {
  final String message;
  WishlistError(this.message);
}
