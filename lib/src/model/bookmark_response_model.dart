// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookmarkResponse {
  String message;
  List<BookmarkData> data;

  BookmarkResponse({
    required this.message,
    required this.data,
  });

  factory BookmarkResponse.fromMap(Map<String, dynamic> data) {
    var bookmarks = <BookmarkData>[];

    if (data['data'] != null) {
      final mapBookmarks = data['data'] as List;
      if (mapBookmarks.isNotEmpty) {
        bookmarks = mapBookmarks.map((e) => BookmarkData.fromMap(e)).toList();
      }
    }

    return BookmarkResponse(
      message: data['message'],
      data: bookmarks,
    );
  }

  @override
  String toString() {
    return 'BookmarkResponse(message:$message, data:$data)';
  }
}

class BookmarkData {
  int id;
  UserEmbed user;
  PostEmbed post;

  BookmarkData({
    required this.id,
    required this.user,
    required this.post,
  });

  factory BookmarkData.fromMap(Map<String, dynamic> data) {
    return BookmarkData(
      id: data['ID'],
      user: UserEmbed.fromJson(data['user']),
      post: PostEmbed.fromJson(data['post']),
    );
  }

  @override
  String toString() {
    return 'BookmarkModel(bookmarkid:$id user: $user, post: $post)';
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

class PostEmbed {
  int id;
  String postTopic;
  String title;
  String body;

  PostEmbed({
    required this.id,
    required this.postTopic,
    required this.title,
    required this.body,
  });

  factory PostEmbed.fromJson(Map<String, dynamic> data) {
    return PostEmbed(
      id: data['postId'],
      postTopic: data['postTopic'],
      title: data['title'],
      body: data['body'],
    );
  }
}
