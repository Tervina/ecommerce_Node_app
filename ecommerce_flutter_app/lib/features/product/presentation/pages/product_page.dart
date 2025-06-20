import 'package:ecommerce_flutter_app/features/product/presentation/pages/Product_card.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/category_section.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/hover_menu.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/voucher_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/datasources/product_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'custom_footer.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    const int tabsCount = 4;
    const int voucherCount = 1;

    final List<String> sampleImages = [
      'assets/images/voucher1.jpg',
      'assets/images/voucher2.jpg',
      'assets/images/voucher3.jpg',
      'assets/images/voucher4.jpg',
      'assets/images/voucher5.jpg',
    ];
    //BlocProvider makes the BLoC available to all child widgets below it.
    return BlocProvider(
      //This is the function that tells BlocProvider how to create the BLoC instance.
      create: (_) {
        final bloc = ProductBloc(
          //This is your actual BLoC that handles events and states related to products.
          GetAllProducts(
            //A use case class that defines the logic to get all products (usually from a repository). You're injecting it into the bloc because the bloc uses this logic to load data.
            ProductRepositoryImpl(
              //This is your repository, which is a layer between your use case and data sources. It decides where to get the data from (e.g., network, database).
              remoteDataSource: ProductRemoteDataSourceImpl(
                client: http.Client(),
              ),
            ),
          ),
        );
        bloc.add(
            LoadProducts()); //Tells the BLoC: “Hey, go load products from the backend!”
        return bloc;
      },
      child: DefaultTabController(
        initialIndex: 1,
        length: tabsCount,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            flexibleSpace: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.black, // Different color than AppBar
                  padding: const EdgeInsets.symmetric(vertical: 15),
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
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(
                  100), // Height of the widget under AppBar
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text(
                        "Exclusive",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(width: 200),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Home",
                            style: TextStyle(color: Colors.black),
                          )),
                      const SizedBox(width: 20),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Contact",
                            style: TextStyle(color: Colors.black),
                          )),
                      const SizedBox(width: 20),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "About",
                            style: TextStyle(color: Colors.black),
                          )),
                      const SizedBox(width: 20),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.black),
                          )),
                      const SizedBox(width: 20),
                      SearchBar(
                        padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 10),
                        ),
                        constraints: const BoxConstraints(
                            minWidth: 200, maxWidth: 400, minHeight: 30),
                        onTap: () {},
                        hintText: "What are you looking for?",
                        trailing: const <Widget>[Icon(Icons.search)],
                      ),
                      const SizedBox(width: 20),

                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shopping_cart_sharp,
                            color: Colors.black87,
                          )),
                      const SizedBox(width: 20),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.person_4_rounded,
                            color: Colors.black87,
                          ))
                      // Add more widgets...
                    ],
                  ),
                ),
              ),
            ),
          ),

          //BlocBuilder listens for state changes and rebuilds the UI.
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              //Shows a spinner while waiting for the API.
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              //Shows a scrollable list of products.
              else if (state is ProductLoaded) {
                final shuffled = [...state.products]..shuffle();
                final random15 = shuffled.take(15).toList();
                return CustomScrollView(
                  slivers: [
                    // Photo Slider at the top
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(80),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Column(children: [
                                Column(children: [
                                  HoverMenu(
                                    menuItems: const [
                                      'Computers',
                                      'Televisions',
                                      'Cables&Accessories',
                                      'Smart watch',
                                      'Home Supplies'
                                    ],
                                    width: 300,
                                    backgroundColor: const Color.fromARGB(
                                        255, 193, 193, 193),
                                    hoverColor: Colors.green.withOpacity(0.2),
                                    hoverTextColor: Colors.green,
                                    fontSize: 16,
                                  )
                                ]),
                              ]),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: PhotoSlider(
                                images: sampleImages,
                                height: 400,
                                autoPlay: true,
                                autoPlayDuration: const Duration(seconds: 4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 🔴 Add this block: Computer Section (horizontal list)
                    SliverToBoxAdapter(
                      child: CategorySection(
                        sectionType: "Cables & Accessories",
                        products: state.products
                            .where((p) => p.category!
                                .toLowerCase()
                                .contains("computers&accessories"))
                            .toList(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CategorySection(
                        sectionType: "Electronics",
                        products: state.products
                            .where((p) =>
                                p.category!
                                    .toLowerCase()
                                    .contains("bluetooth") ||
                                p.category!.toLowerCase().contains("phones"))
                            .toList(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CategorySection(
                        sectionType: "Supplies",
                        products: state.products
                            .where((p) =>
                                p.category!
                                    .toLowerCase()
                                    .contains("home&kitchen") ||
                                p.category!
                                    .toLowerCase()
                                    .contains("homeimprovement"))
                            .toList(),
                      ),
                    ),

                    // Optional: Add a section title
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Our Products',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Products Grid
                    SliverPadding(
                      padding: const EdgeInsets.all(12),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            // final product = state.products[index];
                            final product = random15[index];
                            return ProductCard(product: product);
                          },
                          // childCount: state.products.length,
                          childCount: random15.length,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomFooter(),
                    ),
                  ],
                );
              }
              //Displays the error message returned from the BLoC.
              else if (state is ProductError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox.shrink(); // Default empty widget
            },
          ),
        ),
      ),
    );
  }
}
