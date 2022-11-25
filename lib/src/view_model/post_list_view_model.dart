import 'package:discussin_mobile/src/model/post_model.dart';
import 'package:discussin_mobile/src/service/post_service.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListNotifier extends ChangeNotifier with FiniteState {
  final _postService = PostService();

  Iterable<Post> _posts = [];

  Iterable<Post> get posts => _posts;

  Future<void> loadPosts() async {
    setStateAction(StateAction.loading);
    try {
      _posts = await _postService.getPosts();
      setStateAction(StateAction.none);
    } catch (e) {
      setStateAction(StateAction.error);
    }
  }
}

final postListViewModel = ChangeNotifierProvider(
  (ref) {
    return PostListNotifier();
  },
);
