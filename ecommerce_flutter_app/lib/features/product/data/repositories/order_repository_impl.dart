// lib/data/repositories/order_repository_impl.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_app/features/product/domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_data_source.dart';

// Your data layer (API or database) → handled by OrderRemoteDataSource

// Your domain or business layer (Bloc) → handled by OrderBloc

// Basically it’s the bridge that tells your Bloc how to fetch or create orders.

class OrderRepositoryImpl implements OrderRepository {
//   Your repository doesn’t talk to the internet directly.

// Instead, it asks OrderRemoteDataSource to handle API requests (that’s good architecture 👍).
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Order>> getOrders(String token) async {
    final response = await remoteDataSource.getOrders(
        token); //It calls the remote data source to fetch orders from your backend.
    final List data =
        response.data; //The backend responds with JSON (like a list of orders).
    return data
        .map((json) => Order.fromJson(json))
        .toList(); //The code maps each JSON object into a Dart object Order (your entity).

    //It returns a List<Order> that your app can use easily.
  }

  @override
  Future<Order> createOrder(
      Map<String, dynamic> orderData, String token) async {
    final response = await remoteDataSource.createOrder(
        orderData, token); //Sends the order data to your backend.
    return Order.fromJson(response
        .data); //Waits for a response (like order confirmation or created order).
    //Converts the response JSON into an Order object.
    //retuern it
  }
}
