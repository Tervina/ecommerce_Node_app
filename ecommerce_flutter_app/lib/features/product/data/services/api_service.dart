import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_app/core/network/user_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:5000/api", // your backend URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {"Content-Type": "application/json"},
    ),
  );

  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await UserStorage.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            print("⚠️ Unauthorized! Token might be expired.");
          }
          return handler.next(e);
        },
      ),
    );
  }

  // ------------------ SPECIFIC METHODS ------------------

  Future<Response> getProducts() async {
    return await _dio.get("/products");
  }

  Future<Response> getProductById(String id) async {
    return await _dio.get("/products/$id");
  }

  Future<Response> login(String email, String password) async {
    return await _dio.post("/auth/login", data: {
      "email": email,
      "password": password,
    });
  }

  Future<Response> register(String name, String email, String password) async {
    return await _dio.post("/auth/register", data: {
      "name": name,
      "email": email,
      "password": password,
    });
  }

  Future<Response> createOrder(Map<String, dynamic> orderData) async {
    return await _dio.post("/orders", data: orderData);
  }

  // ------------------ ✅ GENERIC METHODS ------------------

  Future<Response> get(String endpoint, {String? token}) async {
    return await _dio.get(
      endpoint,
      options: Options(
        headers: token != null ? {"Authorization": "Bearer $token"} : {},
      ),
    );
  }

  Future<Response> post(String endpoint, dynamic data, {String? token}) async {
    return await _dio.post(
      endpoint,
      data: data,
      options: Options(
        headers: token != null ? {"Authorization": "Bearer $token"} : {},
      ),
    );
  }

  static Future<List<dynamic>> searchProducts(String query) async {
    final response = await http.get(
        Uri.parse('http://localhost:5000/api/products/search?name=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List) return data;
      if (data is Map && data['products'] is List) return data['products'];
      return [];
    } else {
      throw Exception('Failed to search products');
    }
  }
}
