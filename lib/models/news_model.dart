class NewsModel {
  final int id;
  final String newsTitle;
  final String subTitle;
  final String newsContent;
  final bool newsArticleStatus;
  final int newsType;
  final String imageUrl;

  NewsModel({
    required this.id,
    required this.newsTitle,
    required this.subTitle,
    required this.newsContent,
    required this.newsArticleStatus,
    required this.newsType,
    required this.imageUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as int? ?? 0,
      newsTitle: json['newsTitle'] as String? ?? "",
      subTitle: json['subTitle'] as String? ?? "",
      newsContent: json['newsContent'] as String? ?? "",
      newsArticleStatus: json['newsArticleStatus'] as bool? ?? false,
      newsType: json['newsType'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String? ?? "",
    );
  }
}
