import 'package:discussin_mobile/src/model/post_response_model.dart';

class PostDetailResponse {
  String message;
  PostData data;

  PostDetailResponse({
    required this.message,
    required this.data,
  });

  factory PostDetailResponse.fromMap(Map<String, dynamic> data) {
    return PostDetailResponse(
      message: data['message'],
      data: PostData.fromMap(data['data']),
    );
  }
}

class UserEmbed {
  int id;
  String photo;
  String username;

  UserEmbed({
    required this.id,
    required this.photo,
    required this.username,
  });

  factory UserEmbed.fromJson(Map<String, dynamic> data) {
    return UserEmbed(
      id: data['userId'],
      photo: data['photo'],
      username: data['username'],
    );
  }
}

class TopicEmbed {
  int id;
  String name;

  TopicEmbed({
    required this.id,
    required this.name,
  });

  factory TopicEmbed.fromJson(Map<String, dynamic> data) {
    return TopicEmbed(
      id: data['topicId'],
      name: data['topic_name'],
    );
  }
}

class CountEmbed {
  int like;
  int comment;
  int dislike;

  CountEmbed({
    required this.like,
    required this.comment,
    required this.dislike,
  });

  factory CountEmbed.fromJson(Map<String, dynamic> data) {
    return CountEmbed(
      like: data['like'],
      comment: data['comment'],
      dislike: data['dislike'],
    );
  }
}
