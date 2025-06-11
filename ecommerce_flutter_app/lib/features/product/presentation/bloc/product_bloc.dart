import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../../domain/usecases/get_all_products.dart';

//Extends Bloc and connects ProductEvent to ProductState.
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts
      getAllProducts; //This is the use case we inject to fetch products from the repository.

  //Constructor takes the use case and sets the initial state.
  ProductBloc(this.getAllProducts) : super(ProductInitial()) {
    //When the event LoadProducts is triggered, run this logic.
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading()); //Tell UI we're loading.

      //Calls the use case → gets products → emits success or error state.
      try {
        final products = await getAllProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Failed to load products: ${e.toString()}'));
      }
    });
  }
}
