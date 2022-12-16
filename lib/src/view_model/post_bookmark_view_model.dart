import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/model/bookmark_response_model.dart';
import 'package:discussin_mobile/src/service/bookmark_service.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostBookmarkNotifier extends ChangeNotifier with FiniteState {
  final _bookmarkService = BookmarkService();

  Iterable<BookmarkData> get bookmarks => _bookmarks;
  Iterable<BookmarkData> _bookmarks = [];

  Future<void> getBookmark() async {
    setStateAction(StateAction.loading);
    try {
      final result = await _bookmarkService.getBookmark();
      _bookmarks = result.data;
      notifyListeners();
      setStateAction(StateAction.none);
    } on DioError catch (error) {
      setStateAction(StateAction.error);
      print(error.response?.data);
    }
  }

  Future<bool> reloadBookmark() async {
    final result = await _bookmarkService.getBookmark();
    _bookmarks = result.data;
    notifyListeners();
    return true;
  }

  Future<void> deleteBookmark(int postId) async {
    setStateAction(StateAction.loading);
    try {
      await _bookmarkService.deleteBookmark(postId);
      reloadBookmark();
      setStateAction(StateAction.none);
    } on DioError catch (error) {
      setStateAction(StateAction.error);
      print(error.response?.data);
    }
  }
}

final postBookmarkViewModel = ChangeNotifierProvider((ref) {
  return PostBookmarkNotifier();
});
