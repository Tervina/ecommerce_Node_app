import 'package:flutter/material.dart';
import '../../domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Image.asset('assets/images/out_of_stock.png'),
            ),
          ),
          const SizedBox(height: 8),
          // Product Name
          Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          // Price
          Text("\$${product.price}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          // Optional: Add discount or stock badge
          if (product.price != null && product.price! > 0)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text("-${product.discountPercentage}",
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
        ],
      ),
    );
  }
}
