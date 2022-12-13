import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/model/post_response_model.dart';
import 'package:discussin_mobile/src/model/topic_response_model.dart' as tpc;
import 'package:discussin_mobile/src/service/bookmark_service.dart';
import 'package:discussin_mobile/src/service/like_service.dart';
import 'package:discussin_mobile/src/service/post_service.dart';
import 'package:discussin_mobile/src/service/topic_service.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:discussin_mobile/src/view_model/post_search_view_model.dart';
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListNotifier extends ChangeNotifier
    with FiniteState, FiniteStateSearch
    implements PostLikeable {
  final _likeService = LikeService();
  final _bookmarkService = BookmarkService();
  final _postService = PostService();
  final _topicService = TopicService();

  String _selectedTopic = 'All';

  String get selectedTopic => _selectedTopic;

  Iterable<PostData> get posts => _posts;
  Iterable<PostData> _posts = [];

  Future<void> getAllPost() async {
    setStateAction(StateAction.loading);
    try {
      final result = await _postService.getAllPost();
      _posts = result.data;
      notifyListeners();
      setStateAction(StateAction.none);
    } on DioError catch (error) {
      setStateAction(StateAction.error);
      print(error.response?.data);
    }
  }

  Iterable<tpc.Topic> get topics => _topics;
  Iterable<tpc.Topic> _topics = [];

  Future<void> getTopics() async {
    try {
      final result = await _topicService.getTopics();
      _topics = {tpc.Topic(name: 'All', description: ''), ...result.data};
      notifyListeners();
    } on DioError catch (error) {
      print(error.response?.data);
    }
  }

  Future<void> getPostByTopic(String topic) async {
    try {
      if (topic == 'All') {
        final result = await _postService.getAllPost();
        _posts = result.data;
      } else {
        final result = await _postService.getPostsByTopic(topic);
        _posts = result.data;
      }
      notifyListeners();
    } on DioError catch (error) {
      print(error.response?.data);
    }
  }

  Future<void> reloadAllPost() async {
    final result = await _postService.getAllPost();
    _posts = result.data;
    notifyListeners();
  }

  void setSelectedTopic(String newTopic) {
    _selectedTopic = newTopic;
    notifyListeners();
  }

  Future<void> createBookmark(int postId) async {
    await _bookmarkService.createBookmark(postId);
    reloadAllPost();
  }

  Future<void> deleteSingleBookmark(int postId) async {
    final bookmarks = await _bookmarkService.getBookmark();
    final bookmark = bookmarks.data.firstWhere((e) => e.post.id == postId);
    await _bookmarkService.deleteBookmark(bookmark.id);
    reloadAllPost();
  }

  Future<bool> isSaveable(PostData post) async {
    final posts = await _bookmarkService.getBookmark();

    final isBookmarkAlreadyExist =
        posts.data.where((e) => e.post.id == post.id);

    if (isBookmarkAlreadyExist.isNotEmpty) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> doLikePost(int postId) async {
    final result = await _likeService.doLikePost(postId);
    reloadAllPost();
    return result;
  }

  @override
  Future<bool> doDislikePost(int postId) async {
    final result = await _likeService.doDislikePost(postId);
    reloadAllPost();
    return result;
  }

  /// Only Trigger in Post Search Screen
  Iterable<PostData> get postsInSearch => _postsInSearch;
  Iterable<PostData> _postsInSearch = [];

  Future<void> getPostsInSearch() async {
    setStateActionSearch(StateAction.loading);
    try {
      final results = await _postService.getAllPost();
      _postsInSearch = results.data;
      notifyListeners();
      setStateActionSearch(StateAction.none);
    } on DioError catch (_) {
      setStateActionSearch(StateAction.error);
    }
  }

  void searchPost(String input) async {
    if (input.isEmpty) {
      getPostsInSearch();
      return;
    }

    setStateActionSearch(StateAction.loading);
    try {
      final results = await _postService.getAllPost();
      _postsInSearch = results.data.where((e) {
        return e.title.toLowerCase().contains(input.toLowerCase()) ||
            e.topic.name.toLowerCase().contains(input.toLowerCase());
      });
      notifyListeners();
      setStateActionSearch(StateAction.none);
    } on DioError catch (_) {
      setStateActionSearch(StateAction.error);
    }
  }
}

final postListViewModel = ChangeNotifierProvider(
  (ref) {
    return PostListNotifier();
  },
);
