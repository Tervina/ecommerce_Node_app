import 'package:flutter/material.dart';
import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';

class WishlistProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onAddToCart;
  final VoidCallback onRemove;

  const WishlistProductCard({
    Key? key,
    required this.product,
    required this.onAddToCart,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final discountValue = _parseNum(product.discountPercentage);
    final priceValue = _parseNum(product.price);
    final discountedPriceValue = _parseNum(product.discountedPrice);
    final displayPrice =
        discountedPriceValue > 0 ? discountedPriceValue : priceValue;

    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- PRODUCT IMAGE & DISCOUNT BADGE ---
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  product.imageUrl ?? '',
                  height: 100, // compact
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                      'assets/images/out_of_stock.png',
                      height: 100),
                ),
              ),
              if (discountValue > 0)
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "-${discountValue.toStringAsFixed(0)}%",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 10),

          // --- PRODUCT NAME ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              product.name ?? "Unnamed Product",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 5),

          // --- PRODUCT PRICE ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              "\$${displayPrice.toStringAsFixed(2)}",
              style: const TextStyle(
                  fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),

          Spacer(),

          // --- ADD TO CART & DELETE BUTTONS ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onAddToCart,
                    icon: const Icon(Icons.shopping_cart_outlined, size: 14),
                    label: const Text(
                      "Add",
                      style: TextStyle(fontSize: 10),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: onRemove,
                  child: const Icon(Icons.delete, color: Colors.red, size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _parseNum(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }
}
