// ProductEntity is a clean, backend-free product object.

// It’s used in the use cases and BLoC, so they don’t care how the data is fetched.
class ProductEntity {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}
