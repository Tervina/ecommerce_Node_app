// import 'package:ecommerce_flutter_app/core/network/orderService.dart';
// import 'package:ecommerce_flutter_app/core/network/user_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/cart_bloc.dart';
// import '../bloc/cart_state.dart';
// import 'base_scaffold.dart';
// import 'custom_footer.dart';

// class CheckoutPage extends StatelessWidget {
//   CheckoutPage({Key? key}) : super(key: key);
//   TextEditingController fullNameCtrl = TextEditingController();
//   TextEditingController streetCtrl = TextEditingController();
//   TextEditingController cityCtrl = TextEditingController();
//   TextEditingController phoneCtrl = TextEditingController();
//   TextEditingController emailCtrl = TextEditingController();
//   String paymentMethod = "Cash on delivery";

// // Cart items from Bloc or Provider
//   // List cartItems = [];

//   @override
//   Widget build(BuildContext context) {
//     return BaseScaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Left: Billing Form
//                   Expanded(
//                     flex: 2,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Billing Details",
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 16),
//                         _buildTextField("Full Name*", fullNameCtrl),
//                         _buildTextField("Street Address*", streetCtrl),
//                         _buildTextField("Town/City*", cityCtrl),
//                         _buildTextField("Phone Number*", phoneCtrl),
//                         _buildTextField("Email Address*", emailCtrl),
//                         Row(
//                           children: [
//                             Checkbox(value: true, onChanged: (_) {}),
//                             const Text("Save this information for next time")
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(width: 20),

//                   // Right: Order Summary
//                   Expanded(
//                     flex: 1,
//                     child: BlocBuilder<CartBloc, CartState>(
//                       builder: (context, state) {
//                         if (state is CartLoaded) {
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ...state.items.map((item) => ListTile(
//                                     leading: Image.network(item.imageUrl,
//                                         width: 40, height: 40),
//                                     title: Text(item.name),
//                                     trailing: Text("\$${item.price}"),
//                                   )),
//                               const Divider(),
//                               Text("Subtotal: \$${state.total}"),
//                               const Text("Shipping: Free"),
//                               Text("Total: \$${state.total}",
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16)),
//                               const SizedBox(height: 10),

//                               // Payment Options
//                               RadioListTile(
//                                 value: "bank",
//                                 groupValue: "cash",
//                                 onChanged: (v) {},
//                                 title: const Text("Bank"),
//                               ),
//                               RadioListTile(
//                                 value: "cash",
//                                 groupValue: "cash",
//                                 onChanged: (v) {},
//                                 title: const Text("Cash on delivery"),
//                               ),

//                               // Coupon
//                               Row(
//                                 children: [
//                                   const Expanded(
//                                     child: TextField(
//                                       style: TextStyle(color: Colors.white),
//                                       decoration: InputDecoration(
//                                           hintText: "Coupon Code",
//                                           border: OutlineInputBorder()),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   ElevatedButton(
//                                     onPressed: () {},
//                                     child: const Text("Apply Coupon"),
//                                     style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.red),
//                                   ),
//                                 ],
//                               ),

//                               const SizedBox(height: 10),

//                               // Place Order
//                               ElevatedButton(
//                                 onPressed: () async {
//                                   print("Order Placed!");
//                                   String? userId = await UserStorage
//                                       .getUserId(); // 👈 function to get userId or null

//                                   Map<String, dynamic> orderData = {
//                                     "user_id": userId,
//                                     // 👈 will be null if no sign in
//                                     "items": state.items.map((item) {
//                                       return {
//                                         "product_id": item.id.toString(),
//                                         "product_name":
//                                             item.name, // ✅ Include product name
//                                         "quantity": item.quantity,
//                                         "price": item.price
//                                       };
//                                     }).toList(),
//                                     "billingDetails": {
//                                       "fullName": fullNameCtrl.text,
//                                       "streetAddress": streetCtrl.text,
//                                       "apartment": "",
//                                       "city": cityCtrl.text,
//                                       "phone": phoneCtrl.text,
//                                       "email": emailCtrl.text,
//                                     },
//                                     "paymentMethod": paymentMethod,
//                                     "totalAmount": state.total
//                                   };

//                                   await OrderService().createOrder(orderData);
//                                 },
//                                 child: const Text(
//                                   "Place Order",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red),
//                               ),
//                             ],
//                           );
//                         }
//                         return const Center(child: CircularProgressIndicator());
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const CustomFooter(),
//           ],
//         ),
//       ),
//     );
//   }

//   // Reusable text field
//   Widget _buildTextField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextField(
//         controller: controller, // ✅ Store user input here

//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
// }
