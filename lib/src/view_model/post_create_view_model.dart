import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/model/topic_response_model.dart';
import 'package:discussin_mobile/src/service/cloudinary_service.dart';
import 'package:discussin_mobile/src/service/post_service.dart';
import 'package:discussin_mobile/src/service/topic_service.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PostCreateNotifier extends ChangeNotifier with FiniteState {
  final _topicService = TopicService();
  final _postService = PostService();
  final _cloudinaryService = CloudinaryService();

  String get title => _title;
  String _title = '';

  void setTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  String get body => _body;
  String _body = '';

  void setBody(String newBody) {
    _body = newBody;
    notifyListeners();
  }

  String get visibility => _visibility;
  String _visibility = 'public';

  void setVisibility(String visibility) {
    _visibility = visibility;
    notifyListeners();
  }

  String get topicName => _topicName;
  String _topicName = 'Football';

  void setTopicName(String newTopicName) {
    _topicName = newTopicName;
    notifyListeners();
  }

  Iterable<Topic> get topics => _topics;
  Iterable<Topic> _topics = [];

  Future<void> getTopics() async {
    setStateAction(StateAction.loading);
    try {
      final results = await _topicService.getTopics();
      _topics = results.data;
      notifyListeners();
      setStateAction(StateAction.none);
    } on DioError catch (error) {
      setStateAction(StateAction.error);
      print(error.response?.data);
    }
  }

  XFile? get xFile => _xFile;
  XFile? _xFile;

  void setXFile(XFile? newXFile) {
    _xFile = newXFile;
    notifyListeners();
  }

  Future<bool> createPost(String topicName, PostModel post) async {
    setStateAction(StateAction.loading);
    try {
      if (xFile != null) {
        final imageUrl = await _cloudinaryService.uploadImage(xFile!);
        post.photo = imageUrl ?? '';
      }

      final result = await _postService.createPostByTopic(topicName, post);
      setStateAction(StateAction.none);
      return result;
    } on DioError {
      setStateAction(StateAction.error);
      return false;
    }
  }
}

final postCreateViewModel =
    ChangeNotifierProvider<PostCreateNotifier>((ref) => PostCreateNotifier());
