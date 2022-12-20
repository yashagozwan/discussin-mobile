import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/model/comment_response_model.dart';
import 'package:discussin_mobile/src/model/post_response_model.dart';
import 'package:discussin_mobile/src/screen/post_detail/util/finite_state_comment.dart';
import 'package:discussin_mobile/src/service/comment_service.dart';
import 'package:discussin_mobile/src/service/like_service.dart';
import 'package:discussin_mobile/src/service/post_service.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailNotifier extends ChangeNotifier
    with FiniteState, FiniteStateComment
    implements PostLikeable {
  final _likeService = LikeService();
  final _commentService = CommentService();
  final _postService = PostService();

  Iterable<CommentData> get comments => _comments;
  Iterable<CommentData> _comments = [];

  PostData? get post => _post;
  PostData? _post;

  Future<void> createComment(int postId, CommentModel comment) async {
    setStateActionComment(StateAction.loading);
    try {
      await _commentService.createComment(postId, comment);
      setStateActionComment(StateAction.none);
      _reloadCommentById(postId);
      _reloadPostById(postId);
    } on DioError {
      setStateActionComment(StateAction.error);
      return;
    }
  }

  Future<void> getCommentById(int postId) async {
    setStateActionComment(StateAction.loading);
    try {
      final result = await _commentService.getCommentsById(postId);
      _comments = result.data;
      notifyListeners();
      setStateActionComment(StateAction.none);
    } on DioError catch (error) {
      setStateActionComment(StateAction.error);
      print(error.response?.data);
    }
  }

  Future<void> _reloadCommentById(int postId) async {
    final result = await _commentService.getCommentsById(postId);
    _comments = result.data;
    notifyListeners();
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

  Future<void> _reloadPostById(int postId) async {
    final result = await _postService.getPostsById(postId);
    _post = result.data;
    notifyListeners();
  }

  @override
  Future<bool> doLikePost(int postId) async {
    final result = await _likeService.doLikePost(postId);
    _reloadPostById(postId);
    return result;
  }

  @override
  Future<bool> doDislikePost(int postId) async {
    final result = await _likeService.doDislikePost(postId);
    _reloadPostById(postId);

    return result;
  }
}

final postDetailViewModel = ChangeNotifierProvider((ref) {
  return PostDetailNotifier();
});
