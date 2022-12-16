class PostResponse {
  String message;
  List<PostData> data;

  PostResponse({
    required this.message,
    required this.data,
  });

  factory PostResponse.fromMap(Map<String, dynamic> data) {
    var posts = <PostData>[];

    if (data['data'] != null) {
      final mapPosts = data['data'] as List;
      if (mapPosts.isNotEmpty) {
        posts = mapPosts.map((e) => PostData.fromMap(e)).toList();
      }
    }

    return PostResponse(
      message: data['message'],
      data: posts,
    );
  }

  @override
  String toString() {
    return 'PostResponse(message:$message, data:$data)';
  }
}

class PostData {
  int id;
  String title;
  String body;
  String photo;
  int createdAt;
  bool isActive;
  UserEmbed user;
  TopicEmbed topic;
  CountEmbed count;

  PostData({
    required this.id,
    required this.title,
    required this.body,
    required this.photo,
    required this.createdAt,
    required this.isActive,
    required this.user,
    required this.topic,
    required this.count,
  });

  factory PostData.fromMap(Map<String, dynamic> data) {
    return PostData(
      id: data['ID'],
      title: data['title'],
      body: data['body'],
      photo: data['photo'],
      createdAt: data['createdAt'],
      isActive: data['isActive'],
      user: UserEmbed.fromJson(data['user']),
      topic: TopicEmbed.fromJson(data['topic']),
      count: CountEmbed.fromJson(data['count']),
    );
  }

  @override
  String toString() {
    return 'PostModel(id:$id, title:$title, body:$body, photo:$photo, createdAt:$createdAt, isActive:$isActive)';
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
