import 'package:flutter/material.dart';
import 'package:pickle_ball/models/news_model.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsDetailView extends StatelessWidget {
  final NewsModel news;

  const NewsDetailView({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.newsTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hình ảnh ở giữa
            Image.network(
              news.imageUrl,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  AssetUtils.imgSignIn,
                  height: 200,
                  fit: BoxFit.cover,
                );
              },
            ),
            const SizedBox(height: 16),
            // Tiêu đề phụ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                news.subTitle,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            // Nội dung tin tức (HTML)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Html(
                data: news.newsContent,
                style: {
                  "body": Style(
                    fontSize: FontSize(16.0),
                    fontFamily:
                        Theme.of(context).textTheme.bodyMedium?.fontFamily,
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
