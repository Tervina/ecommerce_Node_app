// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/cart_bloc.dart';
// import '../bloc/cart_event.dart';
// import '../bloc/cart_state.dart';
// import '../widgets/custom_footer.dart'; // <-- Your custom footer file

// class CartPage extends StatelessWidget {
//   const CartPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<CartBloc, CartState>(
//               builder: (context, state) {
//                 if (state is CartLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (state is CartLoaded) {
//                   final items = state.items;

//                   if (items.isEmpty) {
//                     return const Center(
//                       child: Text("Your cart is empty"),
//                     );
//                   }

//                   return SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Cart Table
//                           Table(
//                             border: TableBorder.all(color: Colors.black12),
//                             columnWidths: const {
//                               0: FlexColumnWidth(3),
//                               1: FlexColumnWidth(2),
//                               2: FlexColumnWidth(2),
//                               3: FlexColumnWidth(2),
//                             },
//                             children: [
//                               // Table Header
//                               TableRow(
//                                 decoration: const BoxDecoration(
//                                   color: Color(0xFFF5F5F5),
//                                 ),
//                                 children: const [
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text("Product",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text("Price",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text("Quantity",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text("Subtotal",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                   ),
//                                 ],
//                               ),

//                               // Table Rows for Products
//                               ...items.map((item) {
//                                 return TableRow(children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         IconButton(
//                                           icon: const Icon(Icons.close,
//                                               color: Colors.red),
//                                           onPressed: () {
//                                             context
//                                                 .read<CartBloc>()
//                                                 .add(RemoveFromCart(item.id));
//                                           },
//                                         ),
//                                         Image.network(item.imageUrl,
//                                             width: 50, height: 50),
//                                         const SizedBox(width: 8),
//                                         Expanded(child: Text(item.name)),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text("\$${item.price}"),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         IconButton(
//                                           icon: const Icon(Icons.remove),
//                                           onPressed: () {
//                                             if (item.quantity > 1) {
//                                               context.read<CartBloc>().add(
//                                                   UpdateQuantity(
//                                                       productId: item.id,
//                                                       quantity:
//                                                           item.quantity - 1));
//                                             }
//                                           },
//                                         ),
//                                         Text(item.quantity.toString()),
//                                         IconButton(
//                                           icon: const Icon(Icons.add),
//                                           onPressed: () {
//                                             context.read<CartBloc>().add(
//                                                 UpdateQuantity(
//                                                     productId: item.id,
//                                                     quantity:
//                                                         item.quantity + 1));
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child:
//                                         Text("\$${item.price * item.quantity}"),
//                                   ),
//                                 ]);
//                               }).toList(),
//                             ],
//                           ),

//                           const SizedBox(height: 20),

//                           // Return to Shop & Update Cart Buttons
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text("Return To Shop"),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   context.read<CartBloc>().add(LoadCart());
//                                 },
//                                 child: const Text("Update Cart"),
//                               ),
//                             ],
//                           ),

//                           const SizedBox(height: 20),

//                           // Coupon & Cart Total
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               // Coupon Code
//                               Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 150,
//                                     child: TextField(
//                                       decoration: const InputDecoration(
//                                           hintText: "Coupon Code",
//                                           border: OutlineInputBorder()),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   ElevatedButton(
//                                     onPressed: () {},
//                                     child: const Text("Apply Coupon"),
//                                   ),
//                                 ],
//                               ),

//                               // Cart Total Box
//                               Container(
//                                 padding: const EdgeInsets.all(16),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.black12),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Subtotal: \$${state.total}"),
//                                     const Text("Shipping: Free"),
//                                     Text("Total: \$${state.total}",
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16)),
//                                     const SizedBox(height: 10),
//                                     ElevatedButton(
//                                       onPressed: () {},
//                                       child: const Text("Proceed to checkout"),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }

//                 if (state is CartError) {
//                   return Center(child: Text(state.message));
//                 }

//                 return const Center(child: Text("Something went wrong"));
//               },
//             ),
//           ),

//           // Custom Footer - always at the bottom
//           const CustomFooter(),
//         ],
//       ),
//     );
//   }
// }
