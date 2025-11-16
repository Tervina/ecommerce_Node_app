import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';

class CategoryRemoteDataSource {
  final Dio dio;
  final ApiService apiService;

  CategoryRemoteDataSource(this.dio, {required this.apiService});

  Future<Response> getProductsByCategory(String categoryName) async {
    try {
      final response = await dio.get(
        'http://localhost:5000/api/products/category/$categoryName',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> searchProducts(String query) async {
    try {
      final response = await dio.get(
        'http://localhost:5000/api/products/search',
        // 'http://127.0.0.1:5000/api/products/search',

        queryParameters: {'name': query},

        options: Options(
          validateStatus: (status) => status! < 500, // accept 404 as valid
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
