import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pickle_ball/models/comment_model.dart';
import 'package:pickle_ball/services/api_config.dart';
import 'package:pickle_ball/services/auth_service.dart';

class CommentService {
  static const String baseUrl = ApiConfig.baseUrl;

  Future<List<Comment>> getComments(int tournamentId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/comment/tournament/$tournamentId'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer ${await AuthService().getToken()}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<Comment> postComment(String commentText, int tournamentId) async {
    final userId = await AuthService().getUserId();
    final response = await http.post(
      Uri.parse('$baseUrl/api/comment'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer ${await AuthService().getToken()}',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'commentText': commentText,
        'tournamentId': tournamentId,
        'accountId': int.parse(userId ?? '0'),
      }),
    );

    if (response.statusCode == 200) {
      return Comment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post comment');
    }
  }
}
