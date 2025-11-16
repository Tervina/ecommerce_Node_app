import 'package:ecommerce_flutter_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_flutter_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_flutter_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_product_by_id.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/product_details_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/product_details_event.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/product_details_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ProductCard extends StatefulWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // ✅ Create repository once here
  final repository = ProductRepositoryImpl(
    remoteDataSource: ProductRemoteDataSourceImpl(client: http.Client()),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Center(
                child: Image.network(widget.product.imageUrl ?? "",
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Image.asset('assets/images/out_of_stock.png')),
              ),
            ),
            const SizedBox(height: 10),
            // Product Name
            Text(
              widget.product.name ?? "Unnamed Product",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            // const SizedBox(height: 3),
            // Product Price
            Text(
              "\$${widget.product.price?.toStringAsFixed(2) ?? "0.00"}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 5),

            Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.circular(8), // Rounded corners here
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  "${widget.product.discountPercentage}%",
                  style: const TextStyle(color: Colors.white),
                )),
            const Spacer(),
            AddToCartButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => ProductDetailsBloc(
                        getProductById: GetProductById(repository),
                        getAllProducts: GetAllProducts(repository),
                      )..add(LoadProductDetails(widget.product.id ?? "")),
                      child: ProductDetails(productId: widget.product.id ?? ""),
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}

class AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const AddToCartButton({
    super.key,
    required this.onPressed,
    this.text = "Add To Cart",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.shopping_cart_outlined,
            color: Colors.white, size: 18),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          elevation: 0,
        ),
      ),
    );
  }
}
