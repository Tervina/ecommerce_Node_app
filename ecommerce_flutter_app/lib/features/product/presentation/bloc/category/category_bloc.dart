import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<LoadCategoryProducts>((event, emit) async {
      emit(CategoryLoading());
      try {
        final products =
            await repository.getProductsByCategory(event.categoryName);
        emit(CategoryLoaded(products));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}
