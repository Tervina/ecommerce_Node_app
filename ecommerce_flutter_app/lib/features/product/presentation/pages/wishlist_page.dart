import 'package:ecommerce_flutter_app/features/product/presentation/bloc/product/product_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/product/product_state.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/product_details_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/Product_card.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/wishlist_product_card.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/wishlist/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  String? userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserAndWishlist();
  }

  Future<void> _loadUserAndWishlist() async {
    final supabaseUser = Supabase.instance.client.auth.currentUser;

    if (supabaseUser != null) {
      userId = supabaseUser.id;
    } else {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('user_id');
    }

    setState(() => isLoading = false);

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userId == null || userId!.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 120),
                    child: Text(
                      "Please log in to view your wishlist ❤️",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),

                            // Wishlist Horizontal Scroll
                            BlocBuilder<WishlistBloc, WishlistState>(
                              builder: (context, state) {
                                if (state is WishlistLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (state is WishlistError) {
                                  return Center(
                                      child: Text("Error: ${state.message}"));
                                }

                                if (state is WishlistLoaded) {
                                  if (state.items.isEmpty) {
                                    return const Center(
                                        child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 80),
                                      child: Text(
                                        "Your wishlist is empty 🛒",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ));
                                  }

                                  return SizedBox(
                                    height: 250,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.items.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(width: 16),
                                      itemBuilder: (context, index) {
                                        final product =
                                            state.items[index].product;
                                        return WishlistProductCard(
                                          product: product,
                                          onAddToCart: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => ProductDetails(
                                                    productId: product.id),
                                              ),
                                            );
                                          },
                                          onRemove: () {
                                            context.read<WishlistBloc>().add(
                                                RemoveFromWishlist(
                                                    userId!, product.id));
                                          },
                                        );
                                      },
                                    ),
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),

                            const SizedBox(height: 30),

                            const Text(
                              'Just For You 🤞',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 10),
                            // Suggested / Random Products List
                            BlocBuilder<ProductBloc, ProductState>(
                              builder: (context, state) {
                                if (state is ProductLoading) {
                                  return const Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(40),
                                    child: CircularProgressIndicator(),
                                  ));
                                }

                                if (state is ProductLoaded) {
                                  // Shuffle product list
                                  final shuffled = [...state.products]
                                    ..shuffle();
                                  final random15 = shuffled.take(15).toList();

                                  return SizedBox(
                                    height: 350,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: random15.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(width: 12),
                                      itemBuilder: (context, index) {
                                        final product = random15[index];

                                        return ProductCard(
                                          product: product,
                                        );
                                      },
                                    ),
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const CustomFooter(),
                    ],
                  ),
                ),
    );
  }
}
