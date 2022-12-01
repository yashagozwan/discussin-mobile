class PostResponse {
  String message;
  List<PostData> data;

  PostResponse({
    required this.message,
    required this.data,
  });

  factory PostResponse.fromMap(Map<String, dynamic> data) {
    var posts = <PostData>[];

    if (data['data_post'] != null) {
      final mapPosts = data['data_post'] as List;
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
  int userId;
  int topicId;

  PostData({
    required this.id,
    required this.title,
    required this.body,
    required this.photo,
    required this.createdAt,
    required this.isActive,
    required this.userId,
    required this.topicId,
  });

  factory PostData.fromMap(Map<String, dynamic> data) {
    return PostData(
      id: data['ID'],
      title: data['title'],
      body: data['body'],
      photo: data['photo'],
      createdAt: data['createdAt'],
      isActive: data['isActive'],
      userId: data['userId'],
      topicId: data['topicId'],
    );
  }

  @override
  String toString() {
    return 'PostModel(id:$id, title:$title, body:$body, photo:$photo, createdAt:$createdAt, isActive:$isActive, userId:$userId, topicId:$topicId)';
  }
}
