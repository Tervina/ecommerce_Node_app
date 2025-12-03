import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_app/features/product/data/datasources/category_remote_data_source.dart';
import 'package:ecommerce_flutter_app/features/product/data/datasources/order_remote_data_source.dart';
import 'package:ecommerce_flutter_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_flutter_app/features/product/data/repositories/category_repository_impl.dart';
import 'package:ecommerce_flutter_app/features/product/data/repositories/order_repository_impl.dart';
import 'package:ecommerce_flutter_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';
import 'package:ecommerce_flutter_app/features/product/data/services/contact_service.dart';
import 'package:ecommerce_flutter_app/features/product/data/services/wishlist_service.dart';
import 'package:ecommerce_flutter_app/features/product/domain/repositories/order_repository.dart';
import 'package:ecommerce_flutter_app/features/product/domain/repositories/wishlist_repository.dart';
import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_product_by_id.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/cart/cart_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/category/category_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/contact/contact_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/order/order_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/product/product_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/product/product_event.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/productDetails/product_details_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/cart_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/contact_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/login_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/reset_password_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/signUp_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/about_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/checkout_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/product/presentation/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ufwatjrtbxpwawbonpjt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVmd2F0anJ0Ynhwd2F3Ym9ucGp0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ3NjM4ODgsImV4cCI6MjA3MDMzOTg4OH0.zjXUv9mREaBQ658McxPJaHHO0w7EzpbfoJsZml-YZRM',
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce, // This is important!
    ),
  );
  final productRemoteDataSource = ProductRemoteDataSourceImpl(
    client: http.Client(),
  );

  final repository =
      ProductRepositoryImpl(remoteDataSource: productRemoteDataSource);

// Create use case instances
  final getProductById = GetProductById(repository);
  final getAllProducts = GetAllProducts(repository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(
            OrderRepositoryImpl(
              remoteDataSource: OrderRemoteDataSourceImpl(
                apiService: ApiService(),
              ),
            ),
          ),
        ),
        // Add more Blocs here if needed
        BlocProvider(
          create: (context) => CategoryBloc(
            CategoryRepositoryImpl(
              remoteDataSource: CategoryRemoteDataSource(
                Dio(),
                apiService: ApiService(),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ContactBloc(ContactService()),
        ),

        BlocProvider(
          create: (_) => WishlistBloc(
            WishlistRepository(
              WishlistService(),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ProductDetailsBloc(
            getProductById: getProductById,
            getAllProducts: getAllProducts,
          ),
        ),
        BlocProvider(
          create: (_) =>
              ProductBloc(getAllProducts: getAllProducts)..add(LoadProducts()),
        ),
      ],
      child: const MyApp(), // <-- wrap MyApp here
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // <- Show your products here!
      routes: {
        '/home': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/cart': (context) => const CartPage(),
        '/checkout': (context) => const CheckoutPage(),
        '/contact': (context) => const ContactPage(),
        '/signUp': (context) => const SignUpPage(),
        '/login': (context) => const LoginPage(),
        // '/wishlist': (context) => WishlistPage(
        //     userId: Supabase.instance.client.auth.currentUser?.id ?? ''),
        '/wishlist': (context) {
          // Get userId when route is actually navigated to
          final userId = Supabase.instance.client.auth.currentUser?.id ?? '';

          print('🔍 Navigating to wishlist with userId: $userId');

          if (userId.isEmpty) {
            // If no user, redirect to login
            return const LoginPage();
          }

          return WishlistPage();
        },
        '/reset-password': (context) {
          final email = ModalRoute.of(context)!.settings.arguments as String?;
          return ResetPasswordPage(email: email);
        },
      },
    );
  }
}
