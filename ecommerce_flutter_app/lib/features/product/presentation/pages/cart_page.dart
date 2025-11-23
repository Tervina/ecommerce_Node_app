import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../widgets/custom_footer.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: CustomAppBar(),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartInitial) {
            return const Center(
              child: Text("Your cart is empty"),
            );
          }

          if (state is CartLoaded) {
            final items = state.items;

            if (items.isEmpty) {
              return const Center(
                child: Text("Your cart is empty"),
              );
            }

            return SingleChildScrollView(
              // padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🛒 Cart Table
                        Table(
                          border: TableBorder.all(color: Colors.black12),
                          columnWidths: const {
                            0: FlexColumnWidth(3),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(2),
                            3: FlexColumnWidth(2),
                          },
                          children: [
                            // Table Header
                            const TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Product",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Price",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Quantity",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Subtotal",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),

                            // Table Rows
                            ...items.map((item) {
                              return TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.close,
                                            color: Colors.red),
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                              RemoveFromCart(item.product.id));
                                        },
                                      ),
                                      Image.network(
                                        item.product.imageUrl,
                                        width: 50,
                                        height: 50,
                                        errorBuilder: (_, __, ___) => Image.asset(
                                            'assets/images/out_of_stock.png'),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(child: Text(item.product.name)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "\$${item.product.price.toStringAsFixed(2)}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          if (item.quantity > 1) {
                                            context.read<CartBloc>().add(
                                                  UpdateQuantity(
                                                    productId: item.product.id,
                                                    newQuantity:
                                                        item.quantity - 1,
                                                  ),
                                                );
                                          }
                                        },
                                      ),
                                      Text(item.quantity.toString()),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                                UpdateQuantity(
                                                  productId: item.product.id,
                                                  newQuantity:
                                                      item.quantity + 1,
                                                ),
                                              );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "\$${(item.product.price * item.quantity).toStringAsFixed(2)}"),
                                ),
                              ]);
                            }).toList(),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Return To Shop"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.read<CartBloc>().add(const LoadCart());
                              },
                              child: const Text("Update Cart"),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Coupon + Cart Total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        hintText: "Coupon Code",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Apply Coupon"),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Subtotal: \$${state.subtotal.toStringAsFixed(2)}"),
                                  const Text("Shipping: Free"),
                                  Text(
                                    "Total: \$${state.subtotal.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // go to checkout
                                      Navigator.pushNamed(context, '/checkout');
                                    },
                                    child: const Text("Proceed to checkout"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),

                  // 🟢 Footer at the very bottom of the scroll
                  const CustomFooter(),
                ],
              ),
            );
          }

          if (state is CartError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}
