import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/wishlist/wishlist_state.dart';

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
    _checkUserAndLoadWishlist();
  }

  Future<void> _checkUserAndLoadWishlist() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      setState(() {
        userId = user.id;
        isLoading = false;
      });
      context.read<WishlistBloc>().add(LoadWishlist(user.id));
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final savedUserId = prefs.getString('user_id');

    if (savedUserId == null || savedUserId.isEmpty) {
      setState(() {
        userId = null;
        isLoading = false;
      });
      return;
    }

    setState(() {
      userId = savedUserId;
      isLoading = false;
    });

    context.read<WishlistBloc>().add(LoadWishlist(savedUserId));
  }

  @override
  Widget build(BuildContext context) {
    /// 1️⃣ Still loading? show progress
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    /// 2️⃣ Not logged in? Show login message
    if (userId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Wishlist')),
        body: const Center(
          child: Text(
            'Please log in first to see your wishlist',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    /// 3️⃣ Logged in → Show Wishlist
    return Scaffold(
      appBar: AppBar(title: const Text("My Wishlist")),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WishlistError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is WishlistLoaded) {
            if (state.items.isEmpty) {
              return const Center(
                child: Text(
                  "Your wishlist is empty",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final product = state.items[index].product;

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(product.imageUrl, width: 50),
                    title: Text(product.name),
                    subtitle: Text(
                      "Price: ${product.discountedPrice ?? product.price}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<WishlistBloc>().add(
                              RemoveFromWishlist(userId!, product.id),
                            );
                      },
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
