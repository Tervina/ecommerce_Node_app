import 'package:equatable/equatable.dart';

abstract class WishlistEvent {}

class LoadWishlist extends WishlistEvent {
  final String userId;
  LoadWishlist(this.userId);
}

class AddToWishlist extends WishlistEvent {
  final String userId;
  final String productId;
  AddToWishlist(this.userId, this.productId);
}

class RemoveFromWishlist extends WishlistEvent {
  final String userId;
  final String productId;
  RemoveFromWishlist(this.userId, this.productId);
}
