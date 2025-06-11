import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/datasources/product_remote_data_source.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    //BlocProvider makes the BLoC available to all child widgets below it.
    return BlocProvider(
      //This is the function that tells BlocProvider how to create the BLoC instance.
      create: (_) {
        final bloc = ProductBloc(
          GetAllProducts(
            ProductRepositoryImpl(
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
      child: Scaffold(
        appBar: AppBar(title: const Text('Products')),

        //BlocBuilder listens for state changes and rebuilds the UI.
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            //Shows a spinner while waiting for the API.
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            //Shows a scrollable list of products.
            else if (state is ProductLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    leading: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // This runs if the image URL returns 404 or fails to load
                        return Image.asset(
                          'assets/images/out_of_stock.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    title: Text(product.name),
                    subtitle: Text("\$${product.price.toString()}"),
                  );
                },
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
    );
  }
}
