// lib/presentation/bloc/order/order_state.dart
import 'package:ecommerce_flutter_app/features/product/domain/entities/order_entity.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  OrderLoaded(this.orders);
}

class OrderCreated extends OrderState {
  final Order order;
  OrderCreated(this.order);
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}
