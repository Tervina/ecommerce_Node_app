import 'package:ecommerce_flutter_app/features/product/presentation/bloc/cart/cart_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/cart/cart_event.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/product_details_event.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/product_details_state.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/cart_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/Product_card.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/product_details_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    super.initState();
    // Load product details when screen opens
    context
        .read<ProductDetailsBloc>()
        .add(LoadProductDetails(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: CustomAppBar(),
      ),
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Add padding only to content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                      builder: (context, state) {
                        if (state is ProductDetailsLoading) {
                          return const SizedBox(
                            height: 600,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else if (state is ProductDetailsLoaded) {
                          final product = state.product;
                          print("Stock: ${product.stock}");
                          if (product.stock == null) {
                            print("Stock is null");
                          } else {
                            print("Stock name: ${product.stock}");
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🖼 Product details row
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    product.imageUrl.isNotEmpty &&
                                            Uri.tryParse(product.imageUrl)
                                                    ?.isAbsolute ==
                                                true
                                        ? product.imageUrl
                                        : 'https://via.placeholder.com/150',
                                    fit: BoxFit.cover,
                                    width: 400,
                                    height: 400,
                                    errorBuilder: (_, __, ___) => Image.asset(
                                        'assets/images/out_of_stock.png'),
                                  ),
                                  const SizedBox(width: 25),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(product.name,
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 15),
                                        if (product.rating != null)
                                          Row(
                                            children: List.generate(5, (index) {
                                              return Icon(
                                                index < product.rating!.round()
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: Colors.amber,
                                              );
                                            }),
                                          ),
                                        const SizedBox(height: 15),
                                        Text('Price: \$${product.price}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        if (product.discountedPrice != null)
                                          Text(
                                            'Discounted: \$${product.discountedPrice}',
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                        const SizedBox(height: 30),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () => context
                                                  .read<ProductDetailsBloc>()
                                                  .add(DecreaseQuantity()),
                                              icon: const Icon(Icons.remove),
                                            ),
                                            Text('${state.quantity}',
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                            IconButton(
                                              onPressed: () => context
                                                  .read<ProductDetailsBloc>()
                                                  .add(IncreaseQuantity()),
                                              icon: const Icon(Icons.add),
                                            ),
                                            const SizedBox(width: 20),
                                            ElevatedButton(
                                              onPressed: () {
                                                print(
                                                    "Buy ${state.quantity} items of ${product.name}");

                                                context.read<CartBloc>().add(
                                                      AddToCart(
                                                          product: product,
                                                          quantity: state
                                                              .quantity), // make sure you have this event
                                                    );

                                                Navigator.pushNamed(context,
                                                    '/cart'); // navigate to cart page
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 15),
                                              ),
                                              child: const Text("Buy Now",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          children: [
                                            Text(
                                              (product.stock ?? 0) > 0
                                                  ? "In Stock: ${product.stock}"
                                                  : "Out of Stock",
                                              style: TextStyle(
                                                color: (product.stock ?? 0) > 0
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Text(product.description),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 50),

                              // 🆕 Related Products Section
                              if (state.relatedProducts.isNotEmpty) ...[
                                const Text("Related Products",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 360,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.relatedProducts.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 10),
                                    itemBuilder: (context, index) {
                                      final relatedProduct =
                                          state.relatedProducts[index];
                                      return ProductCard(
                                          product: relatedProduct);
                                    },
                                  ),
                                ),
                              ],
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Footer stays after everything
              const CustomFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
