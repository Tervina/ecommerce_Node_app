// import 'dart:async';

// import 'package:dio/dio.dart';
// import 'package:ecommerce_flutter_app/features/product/data/datasources/category_remote_data_source.dart';
// import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';
// import 'package:ecommerce_flutter_app/features/product/presentation/widgets/searchBar_with_autocomplete.dart';
// import 'package:flutter/material.dart';

// class CustomAppBar extends StatefulWidget {
//   const CustomAppBar({
//     super.key,
//   });

//   @override
//   State<CustomAppBar> createState() => _CustomAppBarState();
// }

// class _CustomAppBarState extends State<CustomAppBar> {
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _controller = TextEditingController();
//     final CategoryRemoteDataSource remoteDataSource =
//         CategoryRemoteDataSource(Dio(), apiService: ApiService());
//     Timer? _debounce;
//     List<dynamic> _suggestions = [];

//     void _onSearchChanged(String query) {
//       if (_debounce?.isActive ?? false) _debounce!.cancel();
//       _debounce = Timer(const Duration(milliseconds: 500), () async {
//         if (query.isEmpty) {
//           setState(() => _suggestions = []);
//           return;
//         }

//         try {
//           final response = await remoteDataSource.searchProducts(query);
//           final data = response.data;

//           if (response.statusCode == 200 &&
//               data is Map &&
//               data['products'] is List) {
//             setState(() {
//               _suggestions = data['products'];
//             });
//           } else {
//             setState(() => _suggestions = []);
//           }
//         } catch (e) {
//           print('Search failed: $e');
//         }
//       });
//     }

//     void _onSuggestionTap(String query) {
//       setState(() => _suggestions = []);
//       _controller.text = query;

//       // ✅ Navigate to CategoryPage with query
//       Navigator.pushNamed(
//         context,
//         '/category',
//         arguments: {'searchQuery': query},
//       );
//     }

//     return AppBar(
//       backgroundColor: Colors.grey,
//       flexibleSpace: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             color: Colors.black, // Different color than AppBar
//             padding: const EdgeInsets.symmetric(vertical: 15),
//             child: Row(
//               children: [
//                 const Spacer(),
//                 const Text(
//                   "🔥 Flash Sale 🔥",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const Spacer(),
//                 TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       "English",
//                       style: TextStyle(color: Colors.white),
//                     )),
//                 IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.arrow_drop_down_sharp,
//                       color: Colors.white,
//                     ))
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottom: PreferredSize(
//         preferredSize:
//             const Size.fromHeight(100), // Height of the widget under AppBar
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 const Text(
//                   "Exclusive",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 const SizedBox(width: 200),
//                 TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       "Home",
//                       style: TextStyle(color: Colors.black),
//                     )),
//                 const SizedBox(width: 20),
//                 TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       "Contact",
//                       style: TextStyle(color: Colors.black),
//                     )),
//                 const SizedBox(width: 20),
//                 TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       "About",
//                       style: TextStyle(color: Colors.black),
//                     )),
//                 const SizedBox(width: 20),
//                 TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(color: Colors.black),
//                     )),
//                 const SizedBox(width: 20),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/about');
//                     },
//                     child: const Text(
//                       "About",
//                       style: TextStyle(color: Colors.black),
//                     )),
//                 const SizedBox(width: 20),
//                 SearchBar(
//                   padding: const WidgetStatePropertyAll<EdgeInsets>(
//                     EdgeInsets.symmetric(horizontal: 10),
//                   ),
//                   constraints: const BoxConstraints(
//                       minWidth: 200, maxWidth: 400, minHeight: 30),
//                   onTap: () {
//                     _controller.text = productName;
//                     setState(() => _suggestions = []);

//                     // ✅ Navigate to CategoryPage with search results
//                     Navigator.pushNamed(
//                       context,
//                       '/category',
//                       arguments: {'searchQuery': productName},
//                     );
//                     if (_suggestions.isNotEmpty)
//                       Container(
//                         color: Colors.white,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: _suggestions.length,
//                           itemBuilder: (context, index) {
//                             final product = _suggestions[index];
//                             return ListTile(
//                               title: Text(product['product_name'] ?? ''),
//                               onTap: () =>
//                                   _onSuggestionTap(product['product_name']),
//                             );
//                           },
//                         ),
//                       );
//                   },
//                   hintText: "What are you looking for?",
//                   trailing: const <Widget>[Icon(Icons.search)],
//                   controller: _controller,
//                   onChanged: _onSearchChanged,
//                 ),
//                 // const SearchBarWithAutocomplete(),

//                 const SizedBox(width: 20),

//                 IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.shopping_cart_sharp,
//                       color: Colors.black87,
//                     )),
//                 const SizedBox(width: 20),
//                 IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.person_4_rounded,
//                       color: Colors.black87,
//                     ))
//                 // Add more widgets...
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:ecommerce_flutter_app/features/product/data/datasources/category_remote_data_source.dart';
// import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';

// class CustomAppBar extends StatefulWidget {
//   const CustomAppBar({super.key});

//   @override
//   State<CustomAppBar> createState() => _CustomAppBarState();
// }

// class _CustomAppBarState extends State<CustomAppBar> {
//   final TextEditingController _controller = TextEditingController();
//   final CategoryRemoteDataSource remoteDataSource =
//       CategoryRemoteDataSource(Dio(), apiService: ApiService());

//   Timer? _debounce;
//   List<Map<String, dynamic>> _suggestions = [];

//   void _onSearchChanged(String query) {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();

//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       if (query.isEmpty) {
//         setState(() => _suggestions = []);
//         return;
//       }

//       try {
//         final response = await remoteDataSource.searchProducts(query);
//         final data = response.data;

//         if (response.statusCode == 200) {
//           if (data is Map && data.containsKey('products')) {
//             setState(() {
//               _suggestions = List<Map<String, dynamic>>.from(data['products']);
//             });
//           } else if (data is List) {
//             setState(() {
//               _suggestions = List<Map<String, dynamic>>.from(data);
//             });
//           } else {
//             setState(() => _suggestions = []);
//           }
//         }
//       } catch (e) {
//         print('Search failed: $e');
//         setState(() => _suggestions = []);
//       }
//     });
//   }

//   void _onSuggestionTap(String query) {
//     setState(() => _suggestions = []);
//     _controller.text = query;

//     Navigator.pushNamed(
//       context,
//       '/category',
//       arguments: {'searchQuery': query},
//     );
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(120), // increase height

//       child: AppBar(
//         backgroundColor: Colors.grey[200],
//         elevation: 2,
//         flexibleSpace: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               color: Colors.black,
//               padding: const EdgeInsets.symmetric(vertical: 15),
//               child: Row(
//                 children: [
//                   const Spacer(),
//                   const Text(
//                     "🔥 Flash Sale 🔥",
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                   const Spacer(),
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text("English",
//                         style: TextStyle(color: Colors.white)),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.arrow_drop_down_sharp,
//                         color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(160),
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 // 🔍 Search bar
//                 SearchBar(
//                   controller: _controller,
//                   hintText: "What are you looking for?",
//                   padding: const WidgetStatePropertyAll<EdgeInsets>(
//                     EdgeInsets.symmetric(horizontal: 10),
//                   ),
//                   constraints: const BoxConstraints(
//                     minWidth: 200,
//                     maxWidth: 400,
//                     minHeight: 40,
//                   ),
//                   trailing: const <Widget>[Icon(Icons.search)],
//                   onChanged: _onSearchChanged,
//                 ),

//                 // 🧠 Auto-complete suggestions
//                 if (_suggestions.isNotEmpty)
//                   Container(
//                     margin: const EdgeInsets.only(top: 4),
//                     height: 200,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.black12),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: ListView.builder(
//                       itemCount: _suggestions.length,
//                       itemBuilder: (context, index) {
//                         final product = _suggestions[index];
//                         return ListTile(
//                           title: Text(product['product_name'] ?? ''),
//                           onTap: () =>
//                               _onSuggestionTap(product['product_name']),
//                         );
//                       },
//                     ),
//                   ),

//                 const SizedBox(height: 10),

//                 // 🔗 Navigation Buttons
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       const Text(
//                         "Exclusive",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20),
//                       ),
//                       const SizedBox(width: 200),
//                       TextButton(
//                           onPressed: () {},
//                           child: const Text("Home",
//                               style: TextStyle(color: Colors.black))),
//                       const SizedBox(width: 20),
//                       TextButton(
//                           onPressed: () {},
//                           child: const Text("Contact",
//                               style: TextStyle(color: Colors.black))),
//                       const SizedBox(width: 20),
//                       TextButton(
//                           onPressed: () {},
//                           child: const Text("About",
//                               style: TextStyle(color: Colors.black))),
//                       const SizedBox(width: 20),
//                       TextButton(
//                           onPressed: () {},
//                           child: const Text("Sign Up",
//                               style: TextStyle(color: Colors.black))),
//                       const SizedBox(width: 20),
//                       IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.shopping_cart_sharp,
//                               color: Colors.black87)),
//                       const SizedBox(width: 10),
//                       IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.person_4_rounded,
//                               color: Colors.black87)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:ecommerce_flutter_app/features/product/data/datasources/category_remote_data_source.dart';
// import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';

// class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
//   const CustomAppBar({super.key});

//   @override
//   State<CustomAppBar> createState() => _CustomAppBarState();

//   // 👇 Give the AppBar enough height to fit all children
//   @override
//   Size get preferredSize => const Size.fromHeight(250);
// }

// class _CustomAppBarState extends State<CustomAppBar> {
//   final TextEditingController _controller = TextEditingController();
//   final CategoryRemoteDataSource remoteDataSource =
//       CategoryRemoteDataSource(Dio(), apiService: ApiService());

//   Timer? _debounce;
//   List<Map<String, dynamic>> _suggestions = [];

//   void _onSearchChanged(String query) {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();

//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       if (query.isEmpty) {
//         setState(() => _suggestions = []);
//         return;
//       }

//       try {
//         final response = await remoteDataSource.searchProducts(query);
//         final data = response.data;

//         if (response.statusCode == 200) {
//           if (data is Map && data.containsKey('products')) {
//             setState(() {
//               _suggestions = List<Map<String, dynamic>>.from(data['products']);
//             });
//           } else if (data is List) {
//             setState(() {
//               _suggestions = List<Map<String, dynamic>>.from(data);
//             });
//           } else {
//             setState(() => _suggestions = []);
//           }
//         }
//       } catch (e) {
//         print('Search failed: $e');
//         setState(() => _suggestions = []);
//       }
//     });
//   }

//   void _onSuggestionTap(String query) {
//     setState(() => _suggestions = []);
//     _controller.text = query;

//     Navigator.pushNamed(
//       context,
//       '/category',
//       arguments: {'searchQuery': query},
//     );
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(260), // give enough height
//       child: AppBar(
//         backgroundColor: Colors.grey[200],
//         elevation: 2,
//         automaticallyImplyLeading: false,

//         // ✅ make contents scrollable and safe
//         flexibleSpace: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // prevent overflow
//               children: [
//                 // 🔥 Flash Sale Bar
//                 Container(
//                   width: double.infinity,
//                   color: Colors.black,
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   child: Row(
//                     children: [
//                       const Spacer(),
//                       const Text(
//                         "🔥 Flash Sale 🔥",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                       const Spacer(),
//                       TextButton(
//                         onPressed: () {},
//                         child: const Text("English",
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                       IconButton(
//                         onPressed: () {},
//                         icon: const Icon(Icons.arrow_drop_down_sharp,
//                             color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // 🔍 Search bar + suggestions
//                 Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SearchBar(
//                         controller: _controller,
//                         hintText: "What are you looking for?",
//                         padding: const WidgetStatePropertyAll<EdgeInsets>(
//                           EdgeInsets.symmetric(horizontal: 10),
//                         ),
//                         constraints: const BoxConstraints(
//                           minWidth: 200,
//                           maxWidth: 400,
//                           minHeight: 40,
//                         ),
//                         trailing: const <Widget>[Icon(Icons.search)],
//                         onChanged: _onSearchChanged,
//                       ),
//                       if (_suggestions.isNotEmpty)
//                         Container(
//                           margin: const EdgeInsets.only(top: 4),
//                           height: 200,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.black12),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: ListView.builder(
//                             shrinkWrap: true, // ✅ prevent overflow
//                             itemCount: _suggestions.length,
//                             itemBuilder: (context, index) {
//                               final product = _suggestions[index];
//                               return ListTile(
//                                 title: Text(product['product_name'] ?? ''),
//                                 onTap: () =>
//                                     _onSuggestionTap(product['product_name']),
//                               );
//                             },
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 // 🔗 Navigation Buttons
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       const Text(
//                         "Exclusive",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20),
//                       ),
//                       const SizedBox(width: 200),
//                       TextButton(
//                           onPressed: () {},
//                           child: const Text("Home",
//                               style: TextStyle(color: Colors.black))),
//                       const SizedBox(width: 20),
//                       TextButton(
//                           onPressed: () {},
//                           child: const Text("Contact",
//                               style: TextStyle(color: Colors.black))),
//                       const SizedBox(width: 20),
//                       TextButton(
//                           onPressed: () {},
//                           child: const Text("About",
//                               style: TextStyle(color: Colors.black))),
//                       const SizedBox(width: 20),
//                       TextButton(
//                           onPressed: () {},
//                           child: const Text("Sign Up",
//                               style: TextStyle(color: Colors.black))),
//                       const SizedBox(width: 20),
//                       IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.shopping_cart_sharp,
//                               color: Colors.black87)),
//                       const SizedBox(width: 10),
//                       IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.person_4_rounded,
//                               color: Colors.black87)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// // }
// import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';
// import 'package:ecommerce_flutter_app/presentation/pages/product_details_page.dart';

// import 'package:flutter/material.dart';

// class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
//   const CustomAppBar({super.key});

//   @override
//   State<CustomAppBar> createState() => _CustomAppBarState();

//   @override
//   Size get preferredSize => const Size.fromHeight(140);
// }

// class _CustomAppBarState extends State<CustomAppBar> {
//   final TextEditingController _controller = TextEditingController();
//   List<dynamic> _suggestions = [];

//   void _onSearchChanged(String query) async {
//     if (query.isEmpty) {
//       setState(() => _suggestions = []);
//       return;
//     }

//     try {
//       final results = await ApiService.searchProducts(query);
//       setState(() => _suggestions = results);
//     } catch (e) {
//       debugPrint('Search failed: $e');
//     }
//   }

//   void _onSuggestionTap(dynamic product) {
//     setState(() => _suggestions = []);
//     _controller.clear();
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ProductDetailPage(productId: product['_id']),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // 🔝 Black top strip
//         Container(
//           color: Colors.black,
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Summer Sale! Get 50% off — ShopNow",
//                 style: TextStyle(color: Colors.white, fontSize: 13),
//               ),
//               Row(
//                 children: const [
//                   Text("English ", style: TextStyle(color: Colors.white)),
//                   Icon(Icons.keyboard_arrow_down, color: Colors.white),
//                 ],
//               )
//             ],
//           ),
//         ),

//         // ⚪ White main navigation bar
//         Container(
//           color: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Logo
//               const Text(
//                 "Exclusive",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),

//               // Menu
//               Row(
//                 children: [
//                   _navButton("Home"),
//                   _navButton("Contact"),
//                   _navButton("About"),
//                   _navButton("Sign Up"),
//                 ],
//               ),

//               // Search box + icons
//               Row(
//                 children: [
//                   Container(
//                     width: 250,
//                     height: 38,
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: TextField(
//                       controller: _controller,
//                       onChanged: _onSearchChanged,
//                       decoration: const InputDecoration(
//                         hintText: "What are you looking for?",
//                         border: InputBorder.none,
//                         suffixIcon: Icon(Icons.search),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Icon(Icons.favorite_border),
//                   const SizedBox(width: 16),
//                   const Icon(Icons.shopping_cart_outlined),
//                 ],
//               ),
//             ],
//           ),
//         ),

//         // 🧭 Search suggestions
//         if (_suggestions.isNotEmpty)
//           Container(
//             margin: const EdgeInsets.only(top: 1),
//             padding: const EdgeInsets.symmetric(horizontal: 40),
//             color: Colors.white,
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: _suggestions.length,
//               itemBuilder: (context, index) {
//                 final product = _suggestions[index];
//                 return ListTile(
//                   title: Text(product['product_name'] ?? ''),
//                   onTap: () => _onSuggestionTap(product),
//                 );
//               },
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _navButton(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: TextButton(
//         onPressed: () {},
//         child: Text(
//           title,
//           style: const TextStyle(color: Colors.black),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:ecommerce_flutter_app/features/product/presentation/pages/product_details_page.dart';
// import 'package:flutter/material.dart';

// // Use the real imports in your project:
// import 'package:ecommerce_flutter_app/features/product/data/datasources/category_remote_data_source.dart';
// import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';
// // import 'package:ecommerce_flutter_app/features/product/presentation/pages/product_details.dart'; // <- update if your file/class name differs

// class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
//   const CustomAppBar({super.key});

//   @override
//   State<CustomAppBar> createState() => _CustomAppBarState();

//   @override
//   Size get preferredSize => const Size.fromHeight(140);
// }

// class _CustomAppBarState extends State<CustomAppBar> {
//   final TextEditingController _controller = TextEditingController();
//   final CategoryRemoteDataSource _remote =
//       CategoryRemoteDataSource(Dio(), apiService: ApiService());

//   Timer? _debounce;
//   List<Map<String, dynamic>> _suggestions = [];

//   void _onSearchChanged(String query) {
//     // debounce
//     _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 400), () async {
//       if (query.isEmpty) {
//         setState(() => _suggestions = []);
//         return;
//       }

//       try {
//         final response = await _remote.searchProducts(query);
//         final data = response.data;

//         // backend returns either a List or { products: [...] } — handle both
//         if (response.statusCode == 200 && data != null) {
//           if (data is List) {
//             setState(() {
//               _suggestions = List<Map<String, dynamic>>.from(
//                   data.map((e) => Map<String, dynamic>.from(e)));
//             });
//           } else if (data is Map && data['products'] is List) {
//             setState(() {
//               _suggestions = List<Map<String, dynamic>>.from(
//                   data['products'].map((e) => Map<String, dynamic>.from(e)));
//             });
//           } else {
//             setState(() => _suggestions = []);
//           }
//         } else {
//           setState(() => _suggestions = []);
//         }
//       } catch (e, st) {
//         debugPrint('Search failed: $e\n$st');
//         setState(() => _suggestions = []);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onSuggestionTap(Map<String, dynamic> product) {
//     // guard for id
//     final id = product['_id'] ?? product['id'] ?? product['product_id'];
//     if (id == null) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Product id missing')));
//       return;
//     }

//     // clear suggestions and navigate
//     setState(() => _suggestions = []);
//     _controller.clear();

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         // Use your actual ProductDetails widget name and constructor
//         builder: (_) => ProductDetails(productId: id.toString()),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // top thin black strip
//         Container(
//           color: Colors.black,
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//           child: Row(
//             children: const [
//               Expanded(
//                 child: Text(
//                   "Summer Sale! Get 50% off — ShopNow",
//                   style: TextStyle(color: Colors.white, fontSize: 13),
//                 ),
//               ),
//               Text("English ", style: TextStyle(color: Colors.white)),
//               Icon(Icons.keyboard_arrow_down, color: Colors.white),
//             ],
//           ),
//         ),

//         // main nav row (white)
//         Container(
//           color: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
//           child: Row(
//             children: [
//               // logo
//               const Text(
//                 "Exclusive",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(width: 40),

//               // center menu (you can place an Expanded to push search to right)
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _navButton("Home"),
//                     _navButton("Contact"),
//                     _navButton("About"),
//                     _navButton("Sign Up"),
//                   ],
//                 ),
//               ),

//               // search + icons
//               Row(
//                 children: [
//                   // search box
//                   SizedBox(
//                     width: 360,
//                     child: Material(
//                       // keep suggestions overlay clipped
//                       color: Colors.transparent,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             height: 42,
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                               borderRadius: BorderRadius.circular(6),
//                               border: Border.all(color: Colors.black12),
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: TextField(
//                                     controller: _controller,
//                                     onChanged: _onSearchChanged,
//                                     decoration: const InputDecoration(
//                                       hintText: "What are you looking for?",
//                                       border: InputBorder.none,
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     // pressing search navigates to category page with query
//                                     final q = _controller.text.trim();
//                                     if (q.isNotEmpty) {
//                                       Navigator.pushNamed(context, '/category',
//                                           arguments: {'searchQuery': q});
//                                     }
//                                   },
//                                   icon: const Icon(Icons.search),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // suggestions (absolute-looking under box)
//                           if (_suggestions.isNotEmpty)
//                             Container(
//                               margin: const EdgeInsets.only(top: 6),
//                               constraints: const BoxConstraints(maxHeight: 300),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(8),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.black.withOpacity(0.1),
//                                       blurRadius: 8),
//                                 ],
//                                 border: Border.all(color: Colors.black12),
//                               ),
//                               child: ListView.separated(
//                                 shrinkWrap: true,
//                                 itemCount: _suggestions.length,
//                                 separatorBuilder: (_, __) =>
//                                     const Divider(height: 0),
//                                 itemBuilder: (context, idx) {
//                                   final p = _suggestions[idx];
//                                   final name =
//                                       p['product_name'] ?? p['name'] ?? '';
//                                   final subtitle = p['category'] ?? '';
//                                   return ListTile(
//                                     title: Text(name),
//                                     subtitle: subtitle.isNotEmpty
//                                         ? Text(subtitle)
//                                         : null,
//                                     onTap: () => _onSuggestionTap(
//                                         Map<String, dynamic>.from(p)),
//                                   );
//                                 },
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Icon(Icons.favorite_border),
//                   const SizedBox(width: 12),
//                   const Icon(Icons.shopping_cart_outlined),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _navButton(String t) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       child: TextButton(
//         onPressed: () {},
//         child: Text(t, style: const TextStyle(color: Colors.black)),
//       ),
//     );
//   }
// }
import 'package:ecommerce_flutter_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_product_by_id.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/contact_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/home_page.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ✅ Import your services, repository, bloc, and api
import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';
import 'package:ecommerce_flutter_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/productDetails/product_details_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/productDetails/product_details_event.dart';
import 'package:http/http.dart' as http;

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
                    const Icon(Icons.favorite_border),
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
