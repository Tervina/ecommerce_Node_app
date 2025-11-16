// import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';

// import '../../data/models/order_model.dart';

// class OrderRepository {
//   final ApiService apiService;

//   OrderRepository({required this.apiService});

//   Future<List<OrderModel>> getOrders(String token) async {
//     final response = await apiService.getOrders(token);
//     final List<dynamic> data = response.data;
//     return data.map((json) => OrderModel.fromJson(json)).toList();
//   }

//   Future<OrderModel> createOrder(
//       Map<String, dynamic> orderData, String token) async {
//     final response = await apiService.createOrder(orderData, token);
//     return OrderModel.fromJson(response.data);
//   }
// }
// lib/domain/repositories/order_repository.dart

import 'package:ecommerce_flutter_app/features/product/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders(String token);
  Future<Order> createOrder(Map<String, dynamic> orderData, String token);
}
