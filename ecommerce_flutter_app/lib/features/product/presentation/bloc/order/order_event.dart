// lib/presentation/bloc/order/order_event.dart

abstract class OrderEvent {}

class LoadOrders extends OrderEvent {
  final String token;
  LoadOrders(this.token);
}

class CreateOrderEvent extends OrderEvent {
  final Map<String, dynamic> orderData;
  final String token;
  CreateOrderEvent(this.orderData, this.token);
}
