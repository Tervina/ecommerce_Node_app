abstract class ProductDetailsEvent {}

class LoadProductDetails extends ProductDetailsEvent {
  final String productId;
  LoadProductDetails(this.productId);
}

class IncreaseQuantity extends ProductDetailsEvent {}

class DecreaseQuantity extends ProductDetailsEvent {}
