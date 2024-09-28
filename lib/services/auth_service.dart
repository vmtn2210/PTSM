import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pickle_ball/services/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl = ApiConfig.baseUrl;

  Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/accounts/user-login'),
      headers: {'accept': '*/*', 'Content-Type': 'application/json'},
      body: json.encode({'userName': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final String token = response.body.trim();
      final String userId = _extractUserIdFromToken(token);
      await saveUserId(userId);
      await saveToken(token); 
      return token;
    } else {
      throw 'Failed to login';
    }
  }

  String _extractUserIdFromToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }
    final payload = json
        .decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
    return payload['UserId'] as String;
  }

  Future<void> logout() async {
    await removeUserId();
  }

  Future<bool> isLoggedIn() async {
    final userId = await getUserId();
    return userId != null;
  }

  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
    print("---------> id $userId");
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  Future<void> removeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
  }

  Future<bool> register({
    required String fullName,
    required String dateOfBirth,
    required String address,
    required String email,
    required String phoneNumber,
    required String gender,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/user-registration'),
      headers: {'accept': '*/*', 'Content-Type': 'application/json'},
      body: json.encode({
        'fullName': fullName,
        'dateOfBirth': dateOfBirth,
        'address': address,
        'email': email,
        'phoneNumber': phoneNumber,
        'gender': gender,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
