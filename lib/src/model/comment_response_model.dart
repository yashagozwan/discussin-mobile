class CommentResponse {
  String message;
  List<CommentData> data;

  CommentResponse({
    required this.message,
    required this.data,
  });

  factory CommentResponse.fromMap(Map<String, dynamic> data) {
    var comments = <CommentData>[];

    if (data['data'] != null) {
      final mapComments = data['data'] as List;
      if (mapComments.isNotEmpty) {
        comments = mapComments.map((e) => CommentData.fromMap(e)).toList();
      }
    }

    return CommentResponse(
      message: data['message'],
      data: comments,
    );
  }

  @override
  String toString() {
    return 'CommentResponse(message:$message, data:$data)';
  }
}

class CommentData {
  String body;
  int postId;
  UserEmbed user;

  CommentData({
    required this.body,
    required this.postId,
    required this.user,
  });

  factory CommentData.fromMap(Map<String, dynamic> data) {
    return CommentData(
      body: data['body'],
      postId: data['postId'],
      user: UserEmbed.fromJson(data['user']),
    );
  }

  @override
  String toString() {
    return 'CommentModel(username: body:$body,postId:$postId, userId:)';
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
