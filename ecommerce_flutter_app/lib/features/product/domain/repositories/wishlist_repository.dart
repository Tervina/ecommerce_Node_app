import 'package:ecommerce_flutter_app/features/product/data/models/wishlist_item_model.dart';
import 'package:ecommerce_flutter_app/features/product/data/services/wishlist_service.dart';
import 'package:http/http.dart' as dio;

class WishlistRepository {
  final WishlistService service;

  WishlistRepository(this.service);

  Future<List<WishlistItem>> getWishlist(String userId) async {
    return await service.getWishlist(userId);
  }

  Future<void> addProduct(String userId, String productId) async {
    await service.addToWishlist(userId, productId);
  }

  Future<void> removeProduct(String userId, String productId) async {
    await service.removeFromWishlist(userId, productId);
  }
}
