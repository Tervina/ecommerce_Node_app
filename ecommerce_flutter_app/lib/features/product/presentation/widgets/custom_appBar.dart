import 'package:ecommerce_flutter_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_product_by_id.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/contact_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/home_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/product_details_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ✅ Import your services, repository, bloc, and api
import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';
import 'package:ecommerce_flutter_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/productDetails/product_details_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/productDetails/product_details_event.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  //because it updates dynamically when user types in the search box
  //required for AppBars, to tell Flutter how tall the AppBar should be
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(
      180); //This defines the height (180 px) of the whole AppBar section.
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _controller =
      TextEditingController(); //manages the search bar text
  List<dynamic> _suggestions =
      []; //stores live search results (list of products).

  late final ProductRepositoryImpl
      repository; //handles data fetching logic, connected to your backend

  @override
  void initState() {
    super.initState();

    // ✅ Initialize repository properly with remote data source
    final remoteDataSource = ProductRemoteDataSourceImpl(
        client: http
            .Client()); //Creates an instance of ProductRemoteDataSourceImpl using http.Client() to make API calls.

    repository = ProductRepositoryImpl(
        remoteDataSource:
            remoteDataSource); //Passes that to ProductRepositoryImpl — your central layer to access product data.

    //UI → Repository → DataSource → HTTP (API)
  }

  /// 🔍 Handle user typing and search query
  void _onSearchChanged(String query) async {
    if (query.isEmpty) {
      //Triggered every time the text in the search box changes.

// If input is empty → clear suggestions.
      setState(() => _suggestions = []);
      return;
    }

    try {
      final results = await ApiService.searchProducts(
          query); //Otherwise → calls ApiService.searchProducts(query) (a backend call).

// Updates _suggestions → UI rebuilds with results below the search bar.
      setState(() => _suggestions = results);
    } catch (e) {
      debugPrint('Search failed: $e');
    }
  }

  /// 🛍 Navigate to Product Details screen
  void _onSuggestionTap(dynamic product) {
    setState(() => _suggestions = []);
    _controller.clear();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          //Wrap that page in a BlocProvider, so it has access to ProductDetailsBloc
          create: (_) => ProductDetailsBloc(
            getProductById: GetProductById(repository),
            getAllProducts: GetAllProducts(repository),
          )..add(LoadProductDetails(product['product_id']
              .toString())), //The Bloc fetches product details using the LoadProductDetails event with the selected product’s ID.
          child: ProductDetails(productId: product['product_id'].toString()),

          //User taps → Bloc fetches data → ProductDetailsPage displays details.
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔝 Top Black Strip (Sale info)
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                const Spacer(),
                const Text(
                  "🔥 Flash Sale 🔥",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "English",
                      style: TextStyle(color: Colors.white),
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.white,
                    ))
              ],
            ),
          ),

          // ⚪ White Main Navigation Bar
          Container(
            color: const Color.fromARGB(255, 205, 204, 204),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                const Text(
                  "Exclusive",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                // Menu Buttons
                Row(
                  children: [
                    _navButton("Home", onTap: () {
                      Navigator.pushAndRemoveUntil(
                        //When you want to jump to a screen and clear history
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
//                         If it returns true → keep that route and stop removing.

// If it returns false → remove it and continue.
// Returning false for all makes the stack empty before pushing the new page.
                        (route) =>
                            false, // removes all previous routes (optional)
                      );
                    }),
                    _navButton("Contact", onTap: () {
                      Navigator.pushNamed(context, '/contact');
                    }),
                    _navButton("About", onTap: () {
                      Navigator.pushNamed(context, '/about');
                    }),
                    _navButton("Sign Up", onTap: () {
                      Navigator.pushNamed(context, '/signUp');
                    }),
                  ],
                ),

                // 🔎 Search box and icons
                Row(
                  children: [
                    Container(
                      width: 300,
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextField(
                        controller: _controller,
                        onChanged: _onSearchChanged,
                        decoration: const InputDecoration(
                          hintText: "What are you looking for?",
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // const Icon(Icons.favorite_border),
                    IconButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/wishlist');
                        // context.read<WishlistBloc>().add(
                        //       AddWishlistEvent(userId, product.id),
                        //     );
                        final user = Supabase.instance.client.auth.currentUser;
                        print(
                            "🔍 Supabase user before navigating: ${user?.id}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WishlistPage(),
                            // userId: user?.id ?? ""
                          ),
                        );
                      },
                      icon: const Icon(Icons.favorite_border_outlined),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 🧭 Search Suggestions Dropdown
          if (_suggestions.isNotEmpty)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final product = _suggestions[index];
                  return ListTile(
                    title: Text(product['product_name'] ?? ''),
                    onTap: () => _onSuggestionTap(product),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  /// 🔘 Navigation Button Helper
  /// this is a helper method to avoid repeating the same code for all menu buttons (“Home”, “About”, etc).
  Widget _navButton(String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}
