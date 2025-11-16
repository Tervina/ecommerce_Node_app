import 'package:ecommerce_flutter_app/core/network/user_storage.dart';
import 'package:ecommerce_flutter_app/features/product/data/services/order_service.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/cart_event.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/cart_state.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/order/order_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/order/order_event.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/order/order_state.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController fullNameCtrl = TextEditingController();
  final TextEditingController streetCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  String paymentMethod = "Cash on delivery";
  final OrderService _orderService = OrderService();

  void _placeOrder() async {
    // 🧩 1. Validate billing form
    if (fullNameCtrl.text.isEmpty ||
        streetCtrl.text.isEmpty ||
        cityCtrl.text.isEmpty ||
        phoneCtrl.text.isEmpty ||
        emailCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill in all required billing details.")),
      );
      return;
    }

    // 🧩 2. Get cart data from the CartBloc
    final cartState = context.read<CartBloc>().state;
    if (cartState is! CartLoaded || cartState.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your cart is empty.")),
      );
      return;
    }

    // 🧩 3. Get the user ID from local storage (if logged in)
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id') ?? 'guest';

    // 🧩 4. Build order data dynamically
    final orderData = {
      "user_id": userId,
      "items": cartState.items.map((item) {
        return {
          "product_id": item.product.id,
          "product_name": item.product.name,
          "quantity": item.quantity,
          "price": item.product.price,
        };
      }).toList(),
      "billingDetails": {
        "fullName": fullNameCtrl.text,
        "streetAddress": streetCtrl.text,
        "city": cityCtrl.text,
        "phone": phoneCtrl.text,
        "email": emailCtrl.text,
      },
      "paymentMethod": paymentMethod,
      "totalAmount": cartState.subtotal,
    };

    // 🧩 5. Send to backend
    final result = await _orderService.placeOrder(orderData);

    // 🧩 6. Handle the response
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));

    if (result.contains("success")) {
      // ✅ Clear the cart and form fields
      context.read<CartBloc>().add(const ClearCart());
      fullNameCtrl.clear();
      streetCtrl.clear();
      cityCtrl.clear();
      phoneCtrl.clear();
      emailCtrl.clear();

      // ✅ Navigate to home or order confirmation
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is OrderCreated) {
            // ✅ Clear the cart when the order is created successfully
            context.read<CartBloc>().add(const ClearCart());

            // ✅ Show a success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Order placed successfully!")),
            );

            // ✅ Redirect to Cart page (or Home if you prefer)
            Navigator.pushNamed(context, '/');
          }

          if (state is OrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text("Failed to place order: ${state.message}")),
            );
          }
        },
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(150),
            child: CustomAppBar(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Billing Details",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            _buildTextField("Full Name*", fullNameCtrl),
                            _buildTextField("Street Address*", streetCtrl),
                            _buildTextField("Town/City*", cityCtrl),
                            _buildTextField("Phone Number*", phoneCtrl),
                            _buildTextField("Email Address*", emailCtrl),
                            Row(
                              children: [
                                Checkbox(value: true, onChanged: (_) {}),
                                const Text(
                                    "Save this information for next time")
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state is CartLoaded) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...state.items.map((item) => ListTile(
                                        leading: Image.network(
                                            item.product.imageUrl,
                                            width: 40,
                                            height: 40),
                                        title: Text(item.product.name),
                                        trailing: Text(
                                          "\$${(item.product.price * item.quantity).toStringAsFixed(2)}",
                                        ),
                                      )),
                                  const Divider(),
                                  Text("Subtotal: \$${state.subtotal}"),
                                  const Text("Shipping: Free"),
                                  Text("Total: \$${state.subtotal}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  const SizedBox(height: 10),
                                  RadioListTile(
                                    value: "Bank",
                                    groupValue: paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        paymentMethod = value.toString();
                                      });
                                    },
                                    title: const Text("Bank"),
                                  ),
                                  RadioListTile(
                                    value: "Cash on delivery",
                                    groupValue: paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        paymentMethod = value.toString();
                                      });
                                    },
                                    title: const Text("Cash on delivery"),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: _placeOrder,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: const Text(
                                      "Place Order",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CustomFooter(),
                ],
              ),
            ),
          ),
        ));
  }

  // Reusable text field
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
