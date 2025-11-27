import 'package:flutter_bloc/flutter_bloc.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';
import 'package:ecommerce_flutter_app/features/product/domain/repositories/wishlist_repository.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository repo;

  WishlistBloc(this.repo) : super(WishlistLoading()) {
    on<LoadWishlist>(_load);
    on<AddToWishlist>(_add);
    on<RemoveFromWishlist>(_remove);
  }

  Future<void> _load(LoadWishlist event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      final items = await repo.getWishlist(event.userId);
      emit(WishlistLoaded(items));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _add(AddToWishlist event, Emitter<WishlistState> emit) async {
    await repo.addProduct(event.userId, event.productId);
    add(LoadWishlist(event.userId));
  }

  Future<void> _remove(
      RemoveFromWishlist event, Emitter<WishlistState> emit) async {
    await repo.removeProduct(event.userId, event.productId);
    add(LoadWishlist(event.userId));
  }
}
