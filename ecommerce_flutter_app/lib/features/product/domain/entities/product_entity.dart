// ProductEntity is a clean, backend-free product object.

// It’s used in the use cases and BLoC, so they don’t care how the data is fetched.
class ProductEntity {
  final String id;
  final String name;
  final double price;
  final double? discountedPrice;
  final String description;
  final String imageUrl;
  final String? discountPercentage;
  final String? category;
  final double? rating;
  final int? stock;

  const ProductEntity(
      {required this.id,
      required this.name,
      required this.price,
      this.discountedPrice,
      required this.description,
      required this.imageUrl,
      this.discountPercentage,
      this.category,
      this.rating,
      this.stock});

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'],
      discountedPrice: (json['discountedPrice'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
    );
  }
}
// class ProductEntity {
//   final String id;
//   final String productId;
//   final String name;
//   final double price;
//   final double discountedPrice;
//   final double discountPercentage;
//   final String imageUrl;

//   ProductEntity({
//     required this.id,
//     required this.productId,
//     required this.name,
//     required this.price,
//     required this.discountedPrice,
//     required this.discountPercentage,
//     required this.imageUrl,
//   });

//   factory ProductEntity.fromJson(Map<String, dynamic> json) {
//     double parsePrice(dynamic value) {
//       if (value == null) return 0;
//       return double.tryParse(
//             value.toString().replaceAll("₹", "").replaceAll(",", ""),
//           ) ??
//           0;
//     }

//     double parsePercent(dynamic value) {
//       if (value == null) return 0;
//       return double.tryParse(
//             value.toString().replaceAll("%", ""),
//           ) ??
//           0;
//     }

//     return ProductEntity(
//       id: json["_id"],
//       productId: json["product_id"],
//       name: json["product_name"],
//       price: parsePrice(json["actual_price"]),
//       discountedPrice: parsePrice(json["discounted_price"]),
//       discountPercentage: parsePercent(json["discount_percentage"]),
//       imageUrl: json["img_link"],
//     );
//   }
// }
