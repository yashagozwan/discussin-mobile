import 'dart:ffi';

import 'package:discussin_mobile/src/model/follow_response_model.dart';
import 'package:discussin_mobile/src/model/post_response_model.dart';
import 'package:discussin_mobile/src/service/follow_service.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostFollowNotifier extends ChangeNotifier with FiniteState {
  final _followService = FollowService();

  Iterable<FollowData> get follows => _follows;
  Iterable<FollowData> _follows = [];

  Future<void> getFollow() async {
    setStateAction(StateAction.loading);
    try {
      final result = await _followService.getFollow();
      _follows = result.data;
      notifyListeners();
    } on DioError catch (error) {
      setStateAction(StateAction.error);
      print(error.response?.data);
    }
  }

  Future<void> reloadFollow() async {
    final result = await _followService.getFollow();
    _follows = result.data;
    notifyListeners();
  }

  Future<void> createFollow(int postId) async {
    setStateAction(StateAction.loading);
    try {
      await _followService.createFollow(postId);
      reloadFollow();
    } on DioError catch (error) {
      setStateAction(StateAction.error);
      print(error.response?.data);
    }
  }

  Future<void> deleteFollow(int postId) async {
    setStateAction(StateAction.loading);
    try {
      await _followService.deleteFollow(postId);
      reloadFollow();
    } on DioError catch (error) {
      setStateAction(StateAction.error);
      print(error.response?.data);
    }
  }

  Future<bool> isFollowable(PostData post) async {
    final posts = await _followService.getFollow();

    final isFollowAlreadyExist = posts.data.where((e) => e.post.id == post.id);

    if (isFollowAlreadyExist.isNotEmpty) {
      return false;
    }
    return true;
  }
}

final postFollowViewModel = ChangeNotifierProvider((ref) {
  return PostFollowNotifier();
});
