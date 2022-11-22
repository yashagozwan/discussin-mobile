import 'package:discussin_mobile/src/model/post_model.dart';

class PostService {
  Future<Iterable<Post>> getPosts() async {
    Iterable<Post> posts = [
      Post(
        id: 123,
        name: 'Mengajar',
        description: 'Mengajar adalah',
        userId: 12,
        topicId: 44,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        isActive: true,
      ),
      Post(
        id: 123,
        name: 'Bermain',
        description: 'Mengajar adalah',
        userId: 12,
        topicId: 44,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        isActive: true,
      )
    ];
    return posts;
  }
}
