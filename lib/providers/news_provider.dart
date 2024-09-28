import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pickle_ball/models/news_model.dart';
import 'package:pickle_ball/services/news_service.dart';

final newsProvider = FutureProvider<List<NewsModel>>((ref) async {
  final newsService = NewsService();
  return await newsService.getNews();
});
