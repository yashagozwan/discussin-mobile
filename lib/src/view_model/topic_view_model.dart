import 'package:discussin_mobile/src/model/topic_model.dart';
import 'package:discussin_mobile/src/service/post_service.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopicNotifier extends ChangeNotifier with FiniteState {
  final _postService = PostService();

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
}

final topicViewModel = ChangeNotifierProvider(
  (ref) {
    return TopicNotifier();
  },
);
