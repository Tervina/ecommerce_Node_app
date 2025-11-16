import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'product_card.dart';

class CategorySection extends StatelessWidget {
  final String sectionType;
  final List<ProductEntity> products;

  const CategorySection({
    super.key,
    required this.sectionType,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox(); // Hide empty sections

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              sectionType,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 350, // Enough space for product cards
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
