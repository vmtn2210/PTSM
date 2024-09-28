class Comment {
  final int id;
  final int userId;
  final String? fullName;
  final String commentText;
  final int tournamentId;
  final int createdBy;
  final DateTime createDate;
  final bool isDeleted;
  final int? deleteBy;
  final String? imageUrl;

  Comment({
    required this.id,
    required this.userId,
    this.fullName,
    required this.commentText,
    required this.tournamentId,
    required this.createdBy,
    required this.createDate,
    required this.isDeleted,
    this.deleteBy,
    this.imageUrl,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      fullName: json['fullName'],
      commentText: json['commentText'] ?? "",
      tournamentId: json['tournamentId'] ?? 0,
      createdBy: json['createdBy'] ?? 0,
      createDate: DateTime.parse(
          json['createDate'] ?? DateTime.now().toIso8601String()),
      isDeleted: json['isDeleted'] ?? false,
      deleteBy: json['deleteBy'],
      imageUrl: json['imageUrl'],
    );
  }
}
