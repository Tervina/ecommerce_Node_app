import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_app/features/product/data/datasources/category_remote_data_source.dart';
import 'package:ecommerce_flutter_app/features/product/data/repositories/category_repository_impl.dart';
import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';
import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_flutter_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_product_by_id.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/category/category_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/category/category_event.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/category_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/Product_card.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/category_section.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/hover_menu.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/voucher_slider.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/datasources/product_remote_data_source.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      // create: (_) {
      //   final repository = ProductRepositoryImpl(
      //     remoteDataSource: ProductRemoteDataSourceImpl(client: http.Client()),
      //   );

      //   final bloc = ProductBloc(
      //     GetAllProducts(repository),
      //     GetProductById(repository),
      //     getAllProducts: null,
      //   );

      //   bloc.add(LoadProducts()); // Load products when page opens
      //   return bloc;
      // },
      create: (_) {
        final repository = ProductRepositoryImpl(
          remoteDataSource: ProductRemoteDataSourceImpl(client: http.Client()),
        );

        return ProductBloc(getAllProducts: GetAllProducts(repository))
          ..add(LoadProducts());
      },
      child: DefaultTabController(
        initialIndex: 1,
        length: tabsCount,
        child: Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(150), child: CustomAppBar()),

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
                                  // HoverMenu(
                                  //   menuItems: const [
                                  //     'Computers',
                                  //     'Televisions',
                                  //     'Cables&Accessories',
                                  //     'Smart watch',
                                  //     'Home Supplies'
                                  //   ],
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => BlocProvider(
                                  //           create: (context) => CategoryBloc(
                                  //             CategoryRepositoryImpl(
                                  //               remoteDataSource:
                                  //                   CategoryRemoteDataSource(
                                  //                 Dio(),
                                  //                 apiService: ApiService(),
                                  //               ),
                                  //             ),
                                  //           )..add(LoadCategoryProducts(
                                  //               categoryName)),
                                  //           child: CategoryPage(
                                  //               categoryName: categoryName),
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  //   width: 300,
                                  //   backgroundColor: const Color.fromARGB(
                                  //       255, 193, 193, 193),
                                  //   hoverColor: Colors.green.withOpacity(0.2),
                                  //   hoverTextColor: Colors.green,
                                  //   fontSize: 16,
                                  // )
                                  HoverMenu(
                                    menuItems: const [
                                      'laptop',
                                      'Televisions',
                                      'Cables&Accessories',
                                      'Smart watch',
                                      'Kitchen'
                                    ],
                                    onItemTap: (categoryName) {
                                      // ✅ FIX: use onItemTap, not onTap
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) => CategoryBloc(
                                              CategoryRepositoryImpl(
                                                remoteDataSource:
                                                    CategoryRemoteDataSource(
                                                  Dio(),
                                                  apiService: ApiService(),
                                                ),
                                              ),
                                            )..add(LoadCategoryProducts(
                                                categoryName)),
                                            child: CategoryPage(
                                                categoryName: categoryName),
                                          ),
                                        ),
                                      );
                                    },
                                    width: 300,
                                    backgroundColor: const Color.fromARGB(
                                        255, 193, 193, 193),
                                    hoverColor: Colors.green.withOpacity(0.2),
                                    hoverTextColor: Colors.green,
                                    fontSize: 16,
                                  ),
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
                              color: Colors.red),
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
                          childAspectRatio: 0.75, // Controls card height/width
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
                    const SliverToBoxAdapter(
                      child: CustomFooter(),
                    ),
                  ],
                );
              } else if (state is ProductError) {
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
