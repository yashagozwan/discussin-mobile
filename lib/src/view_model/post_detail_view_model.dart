import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/model/comment_response_model.dart';
import 'package:discussin_mobile/src/model/post_response_model.dart';
import 'package:discussin_mobile/src/service/comment_service.dart';
import 'package:discussin_mobile/src/service/post_service.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailNotifier extends ChangeNotifier with FiniteState {
  final _commentService = CommentService();
  final _postService = PostService();

  Iterable<CommentData> get comments => _comments;
  Iterable<CommentData> _comments = [];

  PostData? get post => _post;
  PostData? _post;

  Future<void> createComment(int postId, CommentModel comment) async {
    setStateAction(StateAction.loading);
    try {
      await _commentService.createComment(postId, comment);
      setStateAction(StateAction.none);
    } on DioError {
      setStateAction(StateAction.error);
      return;
    }
  }

  Future<void> getCommentById(int postId) async {
    setStateAction(StateAction.loading);
    try {
      final result = await _commentService.getCommentsById(postId);
      _comments = result.data;
      notifyListeners();
      setStateAction(StateAction.none);
    } on DioError catch (error) {
      setStateAction(StateAction.error);
      print(error.response?.data);
    }
  }

  Future<void> getPostById(int postId) async {
    setStateAction(StateAction.loading);
    try {
      final result = await _postService.getPostsById(postId);
      _post = result.data;
      notifyListeners();
      setStateAction(StateAction.none);
    } on DioError catch (error) {
      setStateAction(StateAction.error);
      print(error.response?.data);
    }
  }
}

final postDetailViewModel = ChangeNotifierProvider((ref) {
  return PostDetailNotifier();
});
