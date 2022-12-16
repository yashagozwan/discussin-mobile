class Post {
  int id;
  String title;
  String body;
  String? photo;
  User user;
  Topic topic;
  List<Comment>? comments;
  int createAt;
  bool isActive;
  int userId;
  int topicId;

  Post({
    required this.id,
    required this.title,
    required this.body,
    this.photo,
    required this.user,
    required this.topic,
    this.comments,
    required this.createAt,
    required this.isActive,
    required this.userId,
    required this.topicId,
  });

  factory Post.fromJson(Map<String, dynamic> data) {
    return Post(
      id: data['id'],
      title: data['title'],
      body: data['body'],
      user: User.fromJson(data['user']),
      topic: Topic.fromJson(data['topic']),
      createAt: data['createAt'],
      isActive: data['isActive'],
      userId: data['userId'],
      topicId: data['topicId'],
    );
  }
}

class User {
  int id;
  String username;
  String email;
  String password;
  String? photo;
  bool isAdmin;
  String banUntil;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    this.photo,
    required this.isAdmin,
    required this.banUntil,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      username: data['username'],
      email: data['email'],
      password: data['password'],
      isAdmin: data['isAdmin'],
      banUntil: data['banUntil'],
    );
  }
}

class Topic {
  int id;
  String name;
  String description;
  String suspended;

  Topic({
    required this.id,
    required this.name,
    required this.description,
    required this.suspended,
  });

  factory Topic.fromJson(Map<String, dynamic> data) {
    return Topic(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      suspended: data['suspended'],
    );
  }
}

class Comment {
  int userId;
  int postId;
  String body;
  bool isFollowed;

  Comment({
    required this.userId,
    required this.postId,
    required this.body,
    required this.isFollowed,
  });

  factory Comment.fromJson(Map<String, dynamic> data) {
    return Comment(
      userId: data['userId'],
      postId: data['postId'],
      body: data['body'],
      isFollowed: data['isFollowed'],
    );
  }
}
