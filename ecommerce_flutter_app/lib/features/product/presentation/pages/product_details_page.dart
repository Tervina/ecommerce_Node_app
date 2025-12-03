import 'package:ecommerce_flutter_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/cart/cart_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/cart/cart_event.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/productDetails/product_details_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/productDetails/product_details_event.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/productDetails/product_details_state.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/wishlist/wishlist_state.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/Product_card.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ecommerce_flutter_app/features/product/data/models/wishlist_item_model.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _initPage();
  }

  Future<void> _initPage() async {
    // Load product details
    context
        .read<ProductDetailsBloc>()
        .add(LoadProductDetails(widget.productId));

    // Get userId from Supabase auth
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      userId = user.id;
    } else {
      // Fallback to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('user_id');
    }

    // Load wishlist if user is logged in
    if (userId != null && userId!.isNotEmpty) {
      context.read<WishlistBloc>().add(LoadWishlist(userId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                builder: (context, state) {
                  if (state is ProductDetailsLoading) {
                    return const SizedBox(
                      height: 600,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is ProductDetailsLoaded) {
                    final product = state.product;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
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
                              errorBuilder: (_, __, ___) =>
                                  Image.asset('assets/images/out_of_stock.png'),
                            ),
                            const SizedBox(width: 25),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Name
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 15),
                                  // Rating Stars
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
                                  // Price
                                  Text(
                                    'Price: \$${product.price}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  if (product.discountedPrice != null)
                                    Text(
                                      'Discounted: \$${product.discountedPrice}',
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  const SizedBox(height: 30),
                                  // Quantity + Wishlist + Buy
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => context
                                            .read<ProductDetailsBloc>()
                                            .add(DecreaseQuantity()),
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text('${state.quantity}',
                                          style: const TextStyle(fontSize: 16)),
                                      IconButton(
                                        onPressed: () => context
                                            .read<ProductDetailsBloc>()
                                            .add(IncreaseQuantity()),
                                        icon: const Icon(Icons.add),
                                      ),
                                      const SizedBox(width: 20),

                                      // ❤️ Favorite Icon
                                      if (userId != null && userId!.isNotEmpty)
                                        BlocBuilder<WishlistBloc,
                                            WishlistState>(
                                          builder: (context, wishlistState) {
                                            bool isFavorite = false;
                                            List<WishlistItem> items = [];

                                            if (wishlistState
                                                is WishlistLoaded) {
                                              items = wishlistState.items;
                                              isFavorite = items.any((item) =>
                                                  item.productId == product.id);
                                            }

                                            return
                                                //  IconButton(
                                                //   icon: Icon(
                                                //     isFavorite
                                                //         ? Icons.favorite
                                                //         : Icons.favorite_border,
                                                //     color: isFavorite
                                                //         ? Colors.red
                                                //         : Colors.grey,
                                                //     size: 30,
                                                //   ),
                                                //   onPressed: () {
                                                //     final bloc = context
                                                //         .read<WishlistBloc>();

                                                //     // Optimistic update
                                                //     if (isFavorite) {
                                                //       items.removeWhere((item) =>
                                                //           item.productId ==
                                                //           product.id);
                                                //       bloc.emit(WishlistLoaded(
                                                //           [...items]));
                                                //       bloc.add(RemoveFromWishlist(
                                                //           userId!, product.id));
                                                //     } else {
                                                //       items.add(WishlistItem(
                                                //           productId: product.id,
                                                //           addedAt: DateTime.now(),
                                                //           product: ProductModel(
                                                //               id: product.id,
                                                //               name: product.name,
                                                //               actual_price:
                                                //                   product.price,
                                                //               description: product
                                                //                   .description,
                                                //               imageUrl: product
                                                //                   .imageUrl)));
                                                //       bloc.emit(WishlistLoaded(
                                                //           [...items]));
                                                //       bloc.add(AddToWishlist(
                                                //           userId!, product.id));
                                                //     }
                                                //   },
                                                // );
                                                IconButton(
                                              icon: Icon(
                                                isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: isFavorite
                                                    ? Colors.red
                                                    : Colors.grey,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                final bloc = context
                                                    .read<WishlistBloc>();

                                                if (isFavorite) {
                                                  bloc.add(RemoveFromWishlist(
                                                      userId!, product.id));
                                                } else {
                                                  bloc.add(AddToWishlist(
                                                      userId!, product.id));
                                                }
                                              },
                                            );
                                          },
                                        ),

                                      // Buy Now Button
                                      ElevatedButton(
                                        onPressed: () {
                                          if (state.quantity > 0) {
                                            context.read<CartBloc>().add(
                                                  AddToCart(
                                                      product: product,
                                                      quantity: state.quantity),
                                                );
                                            Navigator.pushNamed(
                                                context, '/cart');
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 15),
                                        ),
                                        child: const Text("Buy Now",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  // Stock
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
                                  const SizedBox(height: 15),
                                  Text(product.description),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        // Related Products
                        if (state.relatedProducts.isNotEmpty) ...[
                          const Text("Related Products",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
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
                                return ProductCard(product: relatedProduct);
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
            ),
            const SizedBox(height: 50),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }
}
