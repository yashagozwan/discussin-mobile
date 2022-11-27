import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PostCreateNotifier extends ChangeNotifier {
  Iterable<String> topics = [
    'Games',
    'Anime',
    'Film',
    'Education',
    'Music',
  ];
  String _visibility = 'public';
  String _topic = 'Games';

  XFile? _xFile;

  String get visibility => _visibility;

  String get topic => _topic;

  XFile? get xFile => _xFile;

  void setVisibility(String visibility) {
    _visibility = visibility;
    notifyListeners();
  }

  void setTopic(String topic) {
    _topic = topic;
    notifyListeners();
  }

  void setXFile(XFile? xFile) {
    _xFile = xFile;
    notifyListeners();
  }
}

final postCreateViewModel =
    ChangeNotifierProvider<PostCreateNotifier>((ref) => PostCreateNotifier());
