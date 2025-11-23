import 'package:dio/dio.dart';

class ContactService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: "http://localhost:5000/api/contact", // change to your server
  ));

  Future<bool> sendContactMessage({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    try {
      final response = await dio.post(
        "/",
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "message": message,
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Failed to send: $e");
    }
  }
}
