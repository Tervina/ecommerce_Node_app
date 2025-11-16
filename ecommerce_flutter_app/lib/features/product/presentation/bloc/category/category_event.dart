abstract class CategoryEvent {}

class LoadCategoryProducts extends CategoryEvent {
  final String categoryName;
  LoadCategoryProducts(this.categoryName);
}
