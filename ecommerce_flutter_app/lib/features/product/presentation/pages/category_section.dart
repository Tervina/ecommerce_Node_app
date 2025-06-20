import 'package:ecommerce_flutter_app/features/product/presentation/pages/Product_card.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';
// import 'product_card.dart'; // your card

class CategorySection extends StatelessWidget {
  final List<ProductEntity> products;
  final String sectionType;
  const CategorySection(
      {super.key, required this.products, required this.sectionType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title and View All
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.square, color: Colors.red, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    "$sectionType",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // You can navigate to a full category page here
                },
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  "View All",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),

          const SizedBox(height: 12),

          // Horizontal List of Products
          SizedBox(
            height: 300, // adjust based on your card height
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
