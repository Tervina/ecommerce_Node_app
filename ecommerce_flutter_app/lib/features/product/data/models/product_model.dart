//This is a data model class. It helps convert JSON data (received from your Node.js backend) into Dart objects that your Flutter app can use, and vice versa.
class ProductModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

//factory constructor is a special way to create an object from something else — in this case, from a JSON map.
//Map<String, dynamic> is a map/dictionary with key-value pairs like "id": "1".
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['product_id'],
      name: json['product_name'],
      price: double.tryParse(
              json['discounted_price'].replaceAll(RegExp(r'[^\d.]'), '')) ??
          0.0,
      description: json['about_product'] ?? '',
      imageUrl: json['img_link'] ?? '',
    );
  }

//It takes a ProductModel object and converts it back into a JSON map.
  Map<String, dynamic> toJson() => {
        'product_id': id,
        'product_name': name,
        'discounted_price': price.toString(),
        'about_product': description,
        'img_link': imageUrl,
      };
}
