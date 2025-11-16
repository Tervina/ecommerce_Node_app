import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_app/core/network/user_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();
  final String baseUrl = "http://localhost:5000/api/auth";

  // 🟢 Sign Up method
  Future<String?> signUp(String name, String email, String password) async {
    try {
      final response = await _dio.post(
        "$baseUrl/signup",
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      if (response.statusCode == 201) {
        return "Signup successful!";
      } else {
        return response.data["message"] ?? "Unknown error";
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response?.data["message"] ?? "Signup failed";
      } else {
        return "Network error: ${e.message}";
      }
    }
  }

  // 🟣 Login method
  // Future<String?> login(String email, String password) async {
  //   try {
  //     final response = await _dio.post(
  //       "$baseUrl/login",
  //       data: {
  //         "email": email,
  //         "password": password,
  //       },
  //       options: Options(
  //         headers: {"Content-Type": "application/json"},
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       // Store the session token
  //       final sessionData = response.data["session"];
  //       if (sessionData != null) {
  //         final prefs = await SharedPreferences.getInstance();
  //         await prefs.setString('access_token', sessionData["access_token"]);
  //         await prefs.setString('refresh_token', sessionData["refresh_token"]);
  //       }

  //       return response.data["message"] ?? "Login successful!";
  //     } else {
  //       return response.data["message"] ??
  //           response.data["error"] ??
  //           "Login failed";
  //     }
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       return e.response?.data["error"] ??
  //           e.response?.data["message"] ??
  //           "Login failed";
  //     } else {
  //       return "Network error: ${e.message}";
  //     }
  //   } catch (e) {
  //     return "Unexpected error: ${e.toString()}";
  //   }
  // }
  // Future<String?> login(String email, String password) async {
  //   try {
  //     final response = await _dio.post(
  //       "$baseUrl/login",
  //       data: {"email": email, "password": password},
  //       options: Options(
  //         headers: {"Content-Type": "application/json"},
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = response.data;

  //       // ✅ Save token and user_id
  //       await UserStorage.saveToken(data['token']);
  //       await UserStorage.saveUserId(data['user_id']);

  //       print("✅ Token saved: ${data['token']}");
  //       print("✅ User ID saved: ${data['user_id']}");

  //       // ✅ Return message (String)
  //       return data['message'] ?? "Login successful";
  //     } else {
  //       return response.data['message'] ?? "Login failed";
  //     }
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       return e.response?.data['message'] ?? "Login failed";
  //     } else {
  //       return "Network error: ${e.message}";
  //     }
  //   } catch (e) {
  //     return "Unexpected error: ${e.toString()}";
  //   }
  // }
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/login',
        data: {'email': email, 'password': password},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // ✅ Convert to String safely
        final token = data['token']?.toString() ?? '';
        final userId = data['user_id']?.toString() ?? 'guest';

        // ✅ Save token and user ID consistently
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);
        await prefs.setString('user_id', userId);

        print("✅ Saved token: $token");
        print("✅ Saved user ID: $userId");

        return {
          'success': true,
          'message': data['message'] ?? 'Login successful!',
          'user_id': userId,
          'token': token,
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Login failed',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Login failed',
      };
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  // 🟡 Google Login method - ADD THIS
  Future<String?> googleLogin(
      String supabaseId, String email, String name) async {
    try {
      final response = await _dio.post(
        "$baseUrl/google-login",
        data: {
          "supabase_id": supabaseId,
          "email": email,
          "name": name,
        },
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      if (response.statusCode == 200) {
        return response.data["message"] ?? "Google login successful!";
      } else {
        return response.data["message"] ?? "Failed to sync with backend";
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response?.data["message"] ?? "Google login failed";
      } else {
        return "Network error: ${e.message}";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  // Get stored token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }
}
