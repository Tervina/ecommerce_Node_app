//This is a data model class. It helps convert JSON data (received from your Node.js backend) into Dart objects that your Flutter app can use, and vice versa.
class ProductModel {
  final String id;
  final String name;
  final String category;
  final double actual_price;
  final double discounted_price;
  final double rating;
  final String description;
  final String imageUrl;
  final String discount_percentage;

  ProductModel(
      {required this.id,
      required this.name,
      required this.category,
      required this.actual_price,
      required this.discounted_price,
      required this.rating,
      required this.description,
      required this.imageUrl,
      required this.discount_percentage});

//factory constructor is a special way to create an object from something else — in this case, from a JSON map.
//Map<String, dynamic> is a map/dictionary with key-value pairs like "id": "1".
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['product_id'],
      name: json['product_name'],
      actual_price: double.tryParse(json['actual_price']
                  ?.toString()
                  .replaceAll(RegExp(r'[^\d.]'), '') ??
              '0') ??
          0.0,
      description: json['about_product'] ?? '',
      imageUrl: json['img_link'] ?? '',
      discount_percentage: json['discount_percentage'] ?? 0,
      discounted_price: double.tryParse(json['discounted_price']
                  ?.toString()
                  .replaceAll(RegExp(r'[^\d.]'), '') ??
              '0') ??
          0.0,
      category: json['category'] ?? '',
      rating: double.tryParse(json['rating']?.toString() ?? '0') ?? 0.0,
    );
  }

//It takes a ProductModel object and converts it back into a JSON map.
  Map<String, dynamic> toJson() => {
        'product_id': id,
        'product_name': name,
        'discounted_actual_price': actual_price.toString(),
        'about_product': description,
        'img_link': imageUrl,
        'discount_percentage': discount_percentage,
        'discounted_price': discounted_price?.toString(),
        'category': category,
        'rating': rating?.toString(),
      };
}
