import 'package:ecommerce_flutter_app/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'features/product/presentation/pages/product_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // await Supabase.initialize(
  //   url: 'https://ufwatjrtbxpwawbonpjt.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVmd2F0anJ0Ynhwd2F3Ym9ucGp0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ3NjM4ODgsImV4cCI6MjA3MDMzOTg4OH0.zjXUv9mREaBQ658McxPJaHHO0w7EzpbfoJsZml-YZRM',
  // );
  runApp(const MyApp());
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
      home: ProductPage(), // <- Show your products here!
      routes: {
        '/about': (context) => const AboutPage(),
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
