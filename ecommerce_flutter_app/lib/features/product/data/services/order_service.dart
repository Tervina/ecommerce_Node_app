// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OrderService {
//   final Dio _dio = Dio();
//   final String baseUrl =
//       "http://localhost:5000/api"; // change if using emulator or web

//   Future<String> placeOrder(Map<String, dynamic> orderData) async {
//     try {
//       // 🟩 Load user_id and token from SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token');
//       final userId = prefs.getString('user_id');

//       print("📦 Retrieved Token: $token");
//       print("📦 Retrieved User ID: $userId");

//       // 🟨 If user is not logged in, fallback to 'guest'
//       orderData['user_id'] = userId ?? 'guest';

//       print("🚀 Sending order data: $orderData");

//       final response = await _dio.post(
//         '$baseUrl/orders',
//         data: orderData,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             if (token != null) 'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       print("📨 Response: ${response.data}");

//       if (response.statusCode == 201) {
//         final message =
//             response.data['message']?.toString() ?? 'Order placed successfully';
//         return message;
//       } else {
//         final message = response.data['message']?.toString() ?? 'Order failed';
//         return message;
//       }
//     } catch (e) {
//       print("❌ Error placing order: $e");
//       return "Something went wrong while placing order";
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  final Dio _dio = Dio();
  final String baseUrl =
      "http://localhost:5000/api"; // ⚠️ Replace this later if needed

  Future<String> placeOrder(Map<String, dynamic> orderData) async {
    try {
      // Load token and user_id
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userId = prefs.getString('user_id');

      print("📦 Retrieved Token: $token");
      print("📦 Retrieved User ID: $userId");

      // Fallback if not logged in
      orderData['user_id'] = userId ?? 'guest';

      print("🚀 Sending order data: $orderData");

      final response = await _dio.post(
        '$baseUrl/orders',
        data: orderData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      print("📨 Response: ${response.data}");

      // ✅ Always handle message safely
      final message =
          response.data['message']?.toString() ?? 'Order placed successfully';
      return message;
    } catch (e) {
      print("❌ Error placing order: $e");
      return "Something went wrong while placing order";
    }
  }
}
