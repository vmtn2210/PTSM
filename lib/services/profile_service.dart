import 'package:dio/dio.dart';
import 'package:pickle_ball/models/user_profile_model.dart';
import 'dart:io';

import 'package:pickle_ball/services/api_config.dart';
import 'package:pickle_ball/services/auth_service.dart';

class ProfileService {
  final Dio _dio = Dio();
  final String _baseUrl = ApiConfig.fullUrl;

  Future<UserProfile> getUserProfile(int userId) async {
    try {
      final authService = AuthService();
      final token = await authService.getToken();
      final response = await _dio.get(
        '$_baseUrl/users/$userId',
        options: Options(
          headers: {
            'accept': 'text/plain',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return UserProfile.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load user profile');
    }
  }

  Future<void> updateUserProfile(int userId, Map<String, dynamic> data) async {
    try {
      final authService = AuthService();
      final token = await authService.getToken();
      await _dio.put(
        '$_baseUrl/users/$userId',
        data: data,
        options: Options(
          headers: {
            'accept': 'text/plain',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      throw Exception('Failed to update user profile');
    }
  }

  Future<String?> uploadImage(File image) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path, filename: fileName),
      });

      final response = await _dio.post(
        '$_baseUrl/image/upload',
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
      );

      if (response.statusCode == 200) {
        return response.data['url'];
      }
    } catch (e) {
      throw Exception('Failed to upload image');
    }
    return null;
  }

  Future<void> resetPassword(String email) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/users/reset-password',
        options: Options(headers: {'accept': 'text/plain'}),
        data: {'email': email},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to reset password');
      }
    } catch (e) {
      throw Exception('Failed to reset password: ${e.toString()}');
    }
  }
}
