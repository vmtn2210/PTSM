import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pickle_ball/models/news_model.dart';
import 'package:pickle_ball/services/api_config.dart';

class NewsService {
  static final String _endpoint = '${ApiConfig.fullUrl}/newarticle';

  Future<List<NewsModel>> getNews() async {
    final response = await http.get(Uri.parse(_endpoint));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => NewsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
