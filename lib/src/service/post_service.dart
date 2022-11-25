import 'package:discussin_mobile/src/model/post_model.dart';
import 'package:discussin_mobile/src/model/topic_model.dart';

class PostService {
  Future<Iterable<Post>> getPosts() async {
    Iterable<Post> posts = [
      Post(
        id: 123,
        name: 'Do you have unforgettable climbing experience?',
        description:
            'It all started back in 2008. I was in my second year of university, and one night my friend Megan decided that she wanted to go to a lecture about mountains as a ploy to meet hot guys, and she dragged me alone',
        userId: 12,
        topicId: 44,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        isActive: true,
      ),
      Post(
        id: 123,
        name: 'Do you have unforgettable climbing experience?',
        description:
            'It all started back in 2008. I was in my second year of university, and one night my friend Megan decided that she wanted to go to a lecture about mountains as a ploy to meet hot guys, and she dragged me alone',
        userId: 12,
        topicId: 44,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        isActive: true,
      ),
    ];
    return posts;
  }

  Future<Iterable<Topic>> getTopics() async {
    Iterable<Topic> topics = [
      Topic(
        id: 1,
        name: 'Popular',
      ),
      Topic(
        id: 2,
        name: 'New',
      ),
      Topic(
        id: 3,
        name: 'Games',
      )
    ];
    return topics;
  }
}
