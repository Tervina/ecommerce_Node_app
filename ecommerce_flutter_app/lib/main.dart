import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_app/features/product/data/datasources/category_remote_data_source.dart';
import 'package:ecommerce_flutter_app/features/product/data/datasources/order_remote_data_source.dart';
import 'package:ecommerce_flutter_app/features/product/data/repositories/category_repository_impl.dart';
import 'package:ecommerce_flutter_app/features/product/data/repositories/order_repository_impl.dart';
import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';
import 'package:ecommerce_flutter_app/features/product/domain/repositories/order_repository.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/category/category_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/order/order_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/cart_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/contact_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/login_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/reset_password_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/signUp_page.dart';
import 'package:ecommerce_flutter_app/presentation/pages/about_page.dart';
import 'package:ecommerce_flutter_app/presentation/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        '/reset-password': (context) {
          final email = ModalRoute.of(context)!.settings.arguments as String?;
          return ResetPasswordPage(email: email);
        },
      },
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'https://ufwatjrtbxpwawbonpjt.supabase.co',
//     anonKey: 'YOUR_KEY',
//   );

//   // ✅ Create data source and repository
//   final remoteDataSource = ProductRemoteDataSourceImpl(client: http.Client());
//   final productRepository = ProductRepositoryImpl(remoteDataSource: remoteDataSource);

//   // ✅ Usecases
//   final getAllProducts = GetAllProducts(productRepository);
//   final getProductById = GetProductById(productRepository);

//   runApp(MultiRepositoryProvider(
//     providers: [
//       RepositoryProvider.value(value: productRepository),
//       RepositoryProvider.value(value: getAllProducts),
//       RepositoryProvider.value(value: getProductById),
//     ],
//     child: MyApp(),
//   ));
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (_) => ProductBloc(
//             RepositoryProvider.of<GetAllProducts>(context),
//             RepositoryProvider.of<GetProductById>(context),
//           ),
//         ),
//       ],
//       child: MaterialApp(
//         navigatorKey: navigatorKey,
//         title: 'E-commerce App',
//         debugShowCheckedModeBanner: false,
//         initialRoute: '/',
//         routes: {
//           '/': (context) => const HomePage(),
//           '/contact': (context) => const ContactPage(),
//           '/about': (context) => const AboutPage(),
//           '/signUp': (context) => const SignUpPage(),
//           '/login': (_) => const LoginPage(),
//           '/forgetPass': (_) => const ForgotPasswordPage(),
//           '/reset-password': (_) => ResetPasswordPage(),
//           '/edit-profile': (_) => const EditProfilePage(),
//           '/categoryItems': (context) {
//             final args = ModalRoute.of(context)!.settings.arguments
//                 as Map<String, dynamic>;
//             return CategoryItemsPage(
//               category: args['category'],
//               products: args['products'],
//             );
//           },
//         },
//         onGenerateRoute: (settings) {
//           if (settings.name == '/product-details') {
//             final args = settings.arguments as Map<String, dynamic>;
//             return MaterialPageRoute(
//               builder: (context) => ProductDetailsPage(productId: args['productId']),
//             );
//           }
//           return null;
//         },
//         theme: ThemeData(primarySwatch: Colors.blue),
//       ),
//     );
//   }
// }
