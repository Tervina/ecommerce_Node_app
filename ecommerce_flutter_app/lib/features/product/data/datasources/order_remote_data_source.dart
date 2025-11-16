// // lib/data/datasources/order_remote_data_source.dart
// import 'package:dio/dio.dart';
// import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';

// abstract class OrderRemoteDataSource {
//   Future<Response> getOrders(String token);
//   Future<Response> createOrder(Map<String, dynamic> orderData, String token);
// }

// class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
//   final ApiService apiService;

//   OrderRemoteDataSourceImpl({required this.apiService});

//   @override
//   Future<Response> getOrders(String token) async {
//     return await apiService.get("/orders", token: token);
//   }

//   @override
//   Future<Response> createOrder(
//       Map<String, dynamic> orderData, String token) async {
//     return await apiService.post("/orders", orderData, token: token);
//   }
// }
import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderRemoteDataSource {
  Future<Response> getOrders(String token);
  Future<Response> createOrder(Map<String, dynamic> orderData, String token);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiService apiService;

  OrderRemoteDataSourceImpl({required this.apiService});

  @override
  Future<Response> getOrders(String token) async {
    return await apiService.get("/orders", token: token);
  }

  @override
  Future<Response> createOrder(
      Map<String, dynamic> orderData, String token) async {
    print("🚀 Sending order data: $orderData");

    return await apiService.post("/orders", orderData, token: token);
  }

  // Future<void> placeOrder(Map<String, dynamic> orderData) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final userId = prefs.getString('user_id'); // ✅ Retrieve user_id

  //     // If user is logged in, attach their ID, otherwise fallback to 'guest'
  //     orderData['user_id'] = userId ?? 'guest';

  //     final response = await Dio().post(
  //       'http://localhost:5000/api/orders',
  //       data: orderData,
  //       options: Options(headers: {'Content-Type': 'application/json'}),
  //     );

  //     print("✅ Order placed successfully: ${response.data}");
  //   } catch (e) {
  //     print("❌ Order failed: $e");
  //   }
  // }
  Future<String> placeOrder(Map<String, dynamic> orderData) async {
    try {
      print("🚀 Sending order data: $orderData");

      final response =
          await Dio().post('http://localhost:5000/api/orders', data: orderData);

      print("📨 Response data: ${response.data}");

      if (response.statusCode == 201) {
        final message =
            response.data['message']?.toString() ?? 'Order placed successfully';
        return message;
      } else {
        final message = response.data['message']?.toString() ?? 'Order failed';
        return message;
      }
    } catch (e) {
      print("❌ Error placing order: $e");
      return "Something went wrong while placing order";
    }
  }
}
