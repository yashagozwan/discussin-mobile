import 'package:discussin_mobile/src/model/topic_model.dart';
import 'package:discussin_mobile/src/service/post_service.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopicNotifier extends ChangeNotifier with FiniteState {
  final _postService = PostService();

  Iterable<Topic> _topics = [];

  Iterable<Topic> get topics => _topics;

  Future<void> loadTopics() async {
    setActionState(StateAction.loading);
    try {
      _topics = await _postService.getTopics();
      setActionState(StateAction.none);
    } catch (e) {
      setActionState(StateAction.error);
    }
  }
}

final topicViewModel = ChangeNotifierProvider(
  (ref) {
    return TopicNotifier();
  },
);
