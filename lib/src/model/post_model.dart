class Post {
  int id;
  String name;
  String description;
  String? imageUrl;
  int userId;
  int topicId;
  int createdAt;
  bool isActive;

  Post({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.userId,
    required this.topicId,
    required this.createdAt,
    required this.isActive,
  });
}
