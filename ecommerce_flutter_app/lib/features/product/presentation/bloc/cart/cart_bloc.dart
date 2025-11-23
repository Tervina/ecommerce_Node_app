import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial()) {
    on<LoadCart>((event, emit) {
      emit(const CartLoaded(items: []));
    });

    on<AddToCart>((event, emit) {
      final currentItems =
          state is CartLoaded ? (state as CartLoaded).items : <CartItem>[];
      final updated = List<CartItem>.from(currentItems);
      final idx = updated.indexWhere((i) => i.product.id == event.product.id);

      if (idx >= 0) {
        updated[idx] = updated[idx]
            .copyWith(quantity: updated[idx].quantity + event.quantity);
      } else {
        updated.add(CartItem(product: event.product, quantity: event.quantity));
      }

      emit(CartLoaded(items: updated));
    });

    on<RemoveFromCart>((event, emit) {
      if (state is CartLoaded) {
        final updated = (state as CartLoaded)
            .items
            .where((i) => i.product.id != event.productId)
            .toList();
        emit(CartLoaded(items: updated));
      }
    });

    on<UpdateQuantity>((event, emit) {
      if (state is CartLoaded) {
        final updated = List<CartItem>.from((state as CartLoaded).items);
        final idx = updated.indexWhere((i) => i.product.id == event.productId);
        if (idx >= 0) {
          updated[idx] = updated[idx].copyWith(quantity: event.newQuantity);
        }
        emit(CartLoaded(items: updated));
      }
    });
    on<ClearCart>((event, emit) async {
      emit(const CartLoading());
      try {
        // 🧹 Clear all items (you can also clear from local storage here)
        emit(const CartLoaded(items: []));
      } catch (e) {
        emit(CartError("Failed to clear cart"));
      }
    });
  }
}
