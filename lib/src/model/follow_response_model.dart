class FollowResponse {
  String message;
  List<FollowData> data;

  FollowResponse({
    required this.message,
    required this.data,
  });

  factory FollowResponse.fromMap(Map<String, dynamic> data) {
    var follows = <FollowData>[];

    if (data['data'] != null) {
      final mapFollows = data['data'] as List;
      if (mapFollows.isNotEmpty) {
        follows = mapFollows.map((e) => FollowData.fromMap(e)).toList();
      }
    }

    return FollowResponse(
      message: data['message'],
      data: follows,
    );
  }

  @override
  String toString() {
    return 'PostResponse(message:$message, data:$data)';
  }
}

class FollowData {
  int id;
  UserFollow user;
  PostFollow post;

  FollowData({
    required this.id,
    required this.user,
    required this.post,
  });

  factory FollowData.fromMap(Map<String, dynamic> data) {
    return FollowData(
      id: data['ID'],
      user: UserFollow.fromJson(data['user']),
      post: PostFollow.fromJson(data['post']),
    );
  }

  @override
  String toString() {
    return 'BookmarkModel(bookmarkid:$id user: $user, post: $post)';
  }
}

class UserFollow {
  int id;
  String username;

  UserFollow({
    required this.id,
    required this.username,
  });

  factory UserFollow.fromJson(Map<String, dynamic> data) {
    return UserFollow(
      id: data['userId'],
      username: data['username'],
    );
  }
}

class PostFollow {
  int id;
  String title;
  String body;

  PostFollow({
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostFollow.fromJson(Map<String, dynamic> data) {
    return PostFollow(
      id: data['postId'],
      title: data['title'],
      body: data['body'],
    );
  }
}
