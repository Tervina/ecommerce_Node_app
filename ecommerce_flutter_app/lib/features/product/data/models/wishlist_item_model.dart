import 'package:ecommerce_flutter_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';

class WishlistItem {
  final String productId;
  final DateTime addedAt;
  final ProductModel product;

  WishlistItem({
    required this.productId,
    required this.addedAt,
    required this.product,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      productId: json['product_id'],
      addedAt: DateTime.parse(json['added_at']),
      product: ProductModel.fromJson(json['product']),
    );
  }
}
