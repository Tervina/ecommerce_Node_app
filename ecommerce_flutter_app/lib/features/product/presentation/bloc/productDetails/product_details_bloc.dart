// import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_all_products.dart';
// import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_product_by_id.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'product_details_event.dart';
// import 'product_details_state.dart';

// class ProductDetailsBloc
//     extends Bloc<ProductDetailsEvent, ProductDetailsState> {
//   final GetProductById getProductById;
//   final GetAllProducts getAllProducts; // <-- inject this

//   int quantity = 1;

//   ProductDetailsBloc({
//     required this.getProductById,
//     required this.getAllProducts, // ✅ Correct
//   }) : super(ProductDetailsInitial()) {
//     on<LoadProductDetails>((event, emit) async {
//       emit(ProductDetailsLoading());
//       try {
//         final product = await getProductById(event.productId);
//         final allProducts =
//             await getAllProducts(); // Your usecase for all products

//         // Filter related products: same category, exclude current product
//         final relatedProducts = allProducts
//             .where((p) => p.category == product.category && p.id != product.id)
//             .toList();
//         emit(ProductDetailsLoaded(
//           product: product,
//           relatedProducts: relatedProducts,
//           quantity: quantity,
//         ));
//       } catch (e) {
//         emit(ProductDetailsError(e.toString()));
//       }
//     });

//     on<IncreaseQuantity>((event, emit) {
//       quantity++;
//       if (state is ProductDetailsLoaded) {
//         final current = state as ProductDetailsLoaded;
//         emit(
//             ProductDetailsLoaded(product: current.product, quantity: quantity));
//       }
//     });

//     on<DecreaseQuantity>((event, emit) {
//       if (quantity > 1) quantity--;
//       if (state is ProductDetailsLoaded) {
//         final current = state as ProductDetailsLoaded;
//         emit(
//             ProductDetailsLoaded(product: current.product, quantity: quantity));
//       }
//     });
//   }
// }
import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_product_by_id.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_details_event.dart';
import 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductById getProductById;
  final GetAllProducts getAllProducts;

  int quantity = 1;
  List<ProductEntity> relatedProducts = [];

  ProductDetailsBloc({
    required this.getProductById,
    required this.getAllProducts,
  }) : super(ProductDetailsInitial()) {
    on<LoadProductDetails>((event, emit) async {
      emit(ProductDetailsLoading());
      try {
        final product = await getProductById(event.productId);
        final allProducts = await getAllProducts();

        // Filter related products
        relatedProducts = allProducts
            .where((p) => p.category == product.category && p.id != product.id)
            .toList();

        emit(ProductDetailsLoaded(
          product: product,
          relatedProducts: relatedProducts,
          quantity: quantity,
        ));
      } catch (e) {
        emit(ProductDetailsError(e.toString()));
      }
    });

    on<IncreaseQuantity>((event, emit) {
      quantity++;
      if (state is ProductDetailsLoaded) {
        final current = state as ProductDetailsLoaded;
        emit(ProductDetailsLoaded(
          product: current.product,
          relatedProducts: current.relatedProducts, // ✅ keep this
          quantity: quantity,
        ));
      }
    });

    on<DecreaseQuantity>((event, emit) {
      if (quantity > 1) quantity--;
      if (state is ProductDetailsLoaded) {
        final current = state as ProductDetailsLoaded;
        emit(ProductDetailsLoaded(
          product: current.product,
          relatedProducts: current.relatedProducts, // ✅ keep this
          quantity: quantity,
        ));
      }
    });
  }
}
