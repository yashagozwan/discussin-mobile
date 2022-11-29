import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Notification {
  String username;
  String topic;

  Notification({
    required this.username,
    required this.topic,
  });
}

class PostNotificationNotifier extends ChangeNotifier with FiniteState {
  List<Notification> _notifications = [];

  List<Notification> get notifications => _notifications;

  void getNotifications() async {
    setStateAction(StateAction.loading);
    try {
      _notifications = [
        Notification(username: 'Marie', topic: 'Games'),
        Notification(username: 'Yosua', topic: 'Programming'),
        Notification(username: 'Kinbe', topic: 'Film'),
        Notification(username: 'Makibe', topic: 'Anime'),
        Notification(username: 'Rimuru', topic: 'Politic'),
        Notification(username: 'Asyura', topic: 'Ghost'),
      ];
      notifyListeners();
      setStateAction(StateAction.none);
    } catch (error) {
      setStateAction(StateAction.error);
    }
  }
}

final postNotificationViewModel =
    ChangeNotifierProvider((ref) => PostNotificationNotifier());
