// //This is a data model class. It helps convert JSON data (received from your Node.js backend) into Dart objects that your Flutter app can use, and vice versa.
// import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';

// class ProductModel {
//   final String id;
//   final String name;
//   final String category;
//   final double actual_price;
//   final double discounted_price;
//   final double rating;
//   final String description;
//   final String imageUrl;
//   final String discount_percentage;

//   ProductModel(
//       {required this.id,
//       required this.name,
//       required this.category,
//       required this.actual_price,
//       required this.discounted_price,
//       required this.rating,
//       required this.description,
//       required this.imageUrl,
//       required this.discount_percentage});

// //factory constructor is a special way to create an object from something else — in this case, from a JSON map.
// //Map<String, dynamic> is a map/dictionary with key-value pairs like "id": "1".
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['product_id'],
//       name: json['product_name'],
//       actual_price: double.tryParse(json['actual_price']
//                   ?.toString()
//                   .replaceAll(RegExp(r'[^\d.]'), '') ??
//               '0') ??
//           0.0,
//       description: json['about_product'] ?? '',
//       imageUrl: json['img_link'] ?? '',
//       discount_percentage: json['discount_percentage'] ?? 0,
//       discounted_price: double.tryParse(json['discounted_price']
//                   ?.toString()
//                   .replaceAll(RegExp(r'[^\d.]'), '') ??
//               '0') ??
//           0.0,
//       category: json['category'] ?? '',
//       rating: double.tryParse(json['rating']?.toString() ?? '0') ?? 0.0,
//     );
//   }

// //It takes a ProductModel object and converts it back into a JSON map.
//   Map<String, dynamic> toJson() => {
//         'product_id': id,
//         'product_name': name,
//         'discounted_actual_price': actual_price.toString(),
//         'about_product': description,
//         'img_link': imageUrl,
//         'discount_percentage': discount_percentage,
//         'discounted_price': discounted_price?.toString(),
//         'category': category,
//         'rating': rating?.toString(),
//       };
// }

// import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';

// class ProductModel extends ProductEntity {
//   const ProductModel({
//     required String id,
//     required String name,
//     required double actual_price,
//     double? discounted_price,
//     required String description,
//     required String imageUrl,
//     String? discountPercentage,
//     String? category,
//     double? rating,
//   }) : super(
//           id: id,
//           name: name,
//           price: actual_price,
//           discountedPrice: discounted_price,
//           description: description,
//           imageUrl: imageUrl,
//           discountPercentage: discountPercentage,
//           category: category,
//           rating: rating,
//         );

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['product_id'] ?? '',
//       name: json['product_name'] ?? '',
//       actual_price:
//           double.tryParse(json['actual_price']?.toString() ?? '0') ?? 0.0,
//       discounted_price:
//           double.tryParse(json['discounted_price']?.toString() ?? '0') ?? 0.0,
//       description: json['about_product'] ?? '',
//       imageUrl: json['img_link'] ?? '',
//       discountPercentage: json['discount_percentage']?.toString(),
//       category: json['category'] ?? '',
//       rating: double.tryParse(json['rating']?.toString() ?? '0') ?? 0.0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'product_id': id,
//       'product_name': name,
//       'actual_price': price,
//       'discounted_price': discountedPrice,
//       'about_product': description,
//       'img_link': imageUrl,
//       'discount_percentage': discountPercentage,
//       'category': category,
//       'rating': rating,
//     };
//   }
// }
import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required String id,
    required String name,
    required double actual_price,
    double? discounted_price,
    required String description,
    required String imageUrl,
    String? discountPercentage,
    String? category,
    double? rating,
  }) : super(
          id: id,
          name: name,
          price: actual_price,
          discountedPrice: discounted_price,
          description: description,
          imageUrl: imageUrl,
          discountPercentage: discountPercentage,
          category: category,
          rating: rating,
        );

  /// Helper method to clean symbols and parse safely
  static double _parsePrice(dynamic value) {
    if (value == null) return 0.0;
    final cleaned = value.toString().replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  /// Helper method to clean discount percentage
  static String? _parseDiscount(dynamic value) {
    if (value == null) return null;
    return value.toString().replaceAll('%', '');
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['product_id'] ?? '',
      name: json['product_name'] ?? '',
      actual_price: _parsePrice(json['actual_price']),
      discounted_price: _parsePrice(json['discounted_price']),
      description: json['about_product'] ?? '',
      imageUrl: json['img_link'] ?? '',
      discountPercentage: _parseDiscount(json['discount_percentage']),
      category: json['category'] ?? '',
      rating: _parsePrice(json['rating']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': id,
      'product_name': name,
      'actual_price': price,
      'discounted_price': discountedPrice,
      'about_product': description,
      'img_link': imageUrl,
      'discount_percentage': discountPercentage,
      'category': category,
      'rating': rating,
    };
  }
}
