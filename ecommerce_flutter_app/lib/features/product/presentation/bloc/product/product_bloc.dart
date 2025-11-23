// import 'package:ecommerce_flutter_app/features/product/domain/entities/product_entity.dart';
// import 'package:ecommerce_flutter_app/features/product/domain/repositories/product_repository.dart';
// import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_product_by_id.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'product_event.dart';
// import 'product_state.dart';
// import '../../domain/usecases/get_all_products.dart';

// //Extends Bloc and connects ProductEvent to ProductState.
// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final GetAllProducts
//       getAllProducts; //This is the use case we inject to fetch products from the repository.
//   final ProductRepository repository;
//   // final GetProductById getProductById;
//   int quantity = 1;

//   //Constructor takes the use case and sets the initial state.
//   ProductBloc(this.getAllProducts, this.repository) : super(ProductInitial()) {
//     //When the event LoadProducts is triggered, run this logic.
//     on<LoadProducts>((event, emit) async {
//       emit(ProductLoading()); //Tell UI we're loading.

//       //Calls the use case → gets products → emits success or error state.
//       try {
//         final products = await getAllProducts();
//         emit(ProductLoaded(products));
//       } catch (e) {
//         emit(ProductError('Failed to load products: ${e.toString()}'));
//       }
//     });
//     // on<FetchProductById>((event, emit) async {
//     //   emit(ProductLoading());
//     //   try {
//     //     final product = await repository.getProductById(event.id);
//     //     emit(ProductLoaded(product as List<ProductEntity>));
//     //   } catch (e) {
//     //     emit(ProductError('Failed to load product: $e'));
//     //   }
//     // });
//   }
// }
import 'package:ecommerce_flutter_app/features/product/domain/usecases/get_all_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;

  ProductBloc({required this.getAllProducts}) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getAllProducts();
        // final relatedProducts = state.products
        //     .where((p) =>
        //         p.category == currentProduct.category &&
        //         p.id != currentProduct.id)
        //     .toList();

        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Failed to load products: ${e.toString()}'));
      }
    });
  }
}
