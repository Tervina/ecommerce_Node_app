import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_app/features/product/data/models/wishlist_item_model.dart';

class WishlistService {
  final Dio _dio;

  WishlistService() : _dio = Dio() {
    // ⚠️ CHANGE THIS TO YOUR BACKEND URL
    _dio.options.baseUrl = 'http://localhost:5000/api'; // For Android Emulator
    // _dio.options.baseUrl = 'http://localhost:3000'; // For iOS Simulator/Web
    // _dio.options.baseUrl = 'http://192.168.1.5:3000'; // For Physical Device

    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);

    // Add logging to see what's happening
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<List<WishlistItem>> getWishlist(String userId) async {
    try {
      final response = await _dio.get('/wishlist/$userId');
      final items = response.data as List;
      return items.map((e) => WishlistItem.fromJson(e)).toList();
    } on DioException catch (e) {
      print('❌ Wishlist GET Error: ${e.message}');
      print('❌ Status Code: ${e.response?.statusCode}');
      print('❌ URL: ${e.requestOptions.uri}');
      rethrow;
    }
  }

  Future<Future<Response>> addToWishlist(
      String userId, String productId) async {
    return _dio.post('/wishlist/add', data: {
      "user_id": userId,
      "product_id": productId,
    });
  }

  Future<Future<Response>> removeFromWishlist(
      String userId, String productId) async {
    return _dio.delete('/wishlist/remove', data: {
      "user_id": userId,
      "product_id": productId,
    });
  }

  Future<List<WishlistItem>> moveAllToCart(String userId) async {
    final response = await _dio.post('/wishlist/move-all', data: {
      "user_id": userId,
    });
    final items = response.data as List;
    return items.map((e) => WishlistItem.fromJson(e)).toList();
  }
}
