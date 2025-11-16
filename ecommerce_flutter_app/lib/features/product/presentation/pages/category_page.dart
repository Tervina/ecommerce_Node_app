// import 'package:ecommerce_flutter_app/features/product/presentation/bloc/category/category_bloc.dart';
// import 'package:ecommerce_flutter_app/features/product/presentation/bloc/category/category_state.dart';
// import 'package:ecommerce_flutter_app/features/product/presentation/widgets/Product_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CategoryPage extends StatelessWidget {
//   final String categoryName;
//   const CategoryPage({super.key, required this.categoryName});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(categoryName)),
//       body: BlocBuilder<CategoryBloc, CategoryState>(
//         builder: (context, state) {
//           if (state is CategoryLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is CategoryLoaded) {
//             return GridView.builder(
//               padding: const EdgeInsets.all(16),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 childAspectRatio: 0.7,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemCount: state.products.length,
//               itemBuilder: (context, index) {
//                 final product = state.products[index];
//                 return Card(
//                   child: Column(
//                     children: [
//                       Image.network(product.imageUrl, height: 100),
//                       Text(product.name),
//                       Text(product.price.toString()),
//                     ],
//                   ),
//                 );
//               },
//             );
//           } else if (state is CategoryError) {
//             return Center(child: Text("Error: ${state.message}"));
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/category/category_bloc.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/bloc/category/category_state.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/product_card.dart'; // ✅ import your card

class CategoryPage extends StatelessWidget {
  final String categoryName;
  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductCard(product: product); // ✅ use your card
              },
            );
          } else if (state is CategoryError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
