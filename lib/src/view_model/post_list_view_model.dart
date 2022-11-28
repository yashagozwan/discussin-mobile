import 'package:discussin_mobile/src/model/post_model.dart';
import 'package:discussin_mobile/src/model/topic_model.dart';
import 'package:discussin_mobile/src/service/post_service.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListNotifier extends ChangeNotifier with FiniteState {
  final _postService = PostService();

  String _selectedTopic = 'All';
  String get selectedTopic => _selectedTopic;

  Iterable<Post> _posts = [];
  Iterable<Post> get posts => _posts;

  Iterable<MyTopic> _topics = [];
  Iterable<MyTopic> get topics => _topics;

  Future<void> loadTopics() async {
    setStateAction(StateAction.loading);
    try {
      _topics = await _postService.getTopics();
      setStateAction(StateAction.none);
    } catch (e) {
      setStateAction(StateAction.error);
    }
  }

  Future<void> loadPosts() async {
    setStateAction(StateAction.loading);
    try {
      _posts = await _postService.getPosts();
      setStateAction(StateAction.none);
    } catch (e) {
      setStateAction(StateAction.error);
    }
  }

  Future<void> getPostByTopic(String topic) async {
    if (topic.isEmpty) {
      loadPosts();
      return;
    }

    if (topic == 'All') {
      loadPosts();
      return;
    }

    setStateAction(StateAction.loading);
    try {
      final result = await _postService.getPosts();
      final postByTopic = result.where(
        (element) {
          return element.topic.name.toLowerCase().contains(topic.toLowerCase());
        },
      );
      _posts = postByTopic;
      notifyListeners();
      setStateAction(StateAction.none);
    } catch (e) {
      setStateAction(StateAction.error);
    }
  }

  void setSelectedTopic(String newTopic) {
    _selectedTopic = newTopic;
    notifyListeners();
  }
}

final postListViewModel = ChangeNotifierProvider(
  (ref) {
    return PostListNotifier();
  },
);
