import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pickle_ball/services/comment_service.dart';
import 'package:pickle_ball/models/comment_model.dart';

final commentProvider =
    StateNotifierProvider.family<CommentNotifier, List<Comment>, int>(
  (ref, tournamentId) => CommentNotifier(CommentService(), tournamentId),
);

class CommentNotifier extends StateNotifier<List<Comment>> {
  final CommentService _commentService;
  final int _tournamentId;

  CommentNotifier(this._commentService, this._tournamentId) : super([]) {
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      final comments = await _commentService.getComments(_tournamentId);
      state = comments;
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  Future<void> addComment(String commentText) async {
    try {
      final newComment =
          await _commentService.postComment(commentText, _tournamentId);
      state = [newComment, ...state];
      await fetchComments();
    } catch (e) {
      print('Error adding comment: $e');
    }
  }
}
