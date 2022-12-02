import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/post_model.dart';
import 'package:discussin_mobile/src/model/post_response_model.dart';
import 'package:discussin_mobile/src/model/topic_model.dart';

class PostModel {
  String title;
  String photo;
  String body;

  PostModel({
    required this.title,
    this.photo = '',
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'photo': photo,
      'body': body,
    };
  }
}

class PostService {
  final _client = DiscussinApi().getClient();

  Future<PostResponse> getAllPost() async {
    try {
      final results = await _client.get('/posts/recents');
      return PostResponse.fromMap(results.data);
    } on DioError {
      rethrow;
    }
  }

  Future<bool> createPostByTopic(String topicName, PostModel post) async {
    try {
      await _client.post('/posts/create/$topicName', data: post.toMap());
      return true;
    } on DioError {
      rethrow;
    }
  }

  Future<PostResponse> getPostsByTopic(String topicName) async {
    try {
      final results = await _client.get('/posts/all/$topicName');
      return PostResponse.fromMap(results.data);
    } on DioError {
      rethrow;
    }
  }

  Future<Iterable<Post>> getPosts() async {
    final posts = [
      Post(
        id: 1,
        title: 'Do you have unforgettable climbing experience?',
        body:
            'It all started back in 2008. I was in my second year of university, and one night my friend Megan decided that she wanted to go to a lecture about mountains as a ploy to meet hot guys, and she dragged me alone, It all started back in 2008. I was in my second year of university, and one night my friend Megan decided that she wanted to go to a lecture about mountains as a ploy to meet hot guys, and she dragged me alonoe. To see Everest, one must go to a lookout called Tiger Hill, thirteen miles to the southeast.',
        photo: 'https://wallpaperaccess.com/full/223237.jpg',
        createAt: 12,
        isActive: true,
        topicId: 1,
        userId: 1,
        comments: [],
        topic: Topic(
          id: 1,
          name: 'Story',
          description: 'Story is Story',
          suspended: '',
        ),
        user: User(
          id: 1,
          email: 'pinkguy@gmail.com',
          username: 'Pink Guy',
          password: 'Pinkguy123',
          photo:
              'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/a288e946906757.586a393b6be47.jpg',
          banUntil: '',
          isAdmin: false,
        ),
      ),
      Post(
        id: 2,
        title: 'Talk about Flutter',
        body:
            'Flutter is Google portable UI toolkit for crafting beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.',
        photo:
            'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png',
        createAt: 12,
        isActive: true,
        topicId: 2,
        userId: 2,
        comments: [],
        topic: Topic(
          id: 2,
          name: 'Programming',
          description: 'Programming is Programming',
          suspended: '',
        ),
        user: User(
          id: 2,
          email: 'pepefrog@gmail.com',
          username: 'Pepe Frog',
          password: 'Pepefrog123',
          photo:
              'https://www.whatspaper.com/wp-content/uploads/2022/01/hd-pepe-the-frog-wallpaper-whatspaper-11.jpg',
          banUntil: '',
          isAdmin: false,
        ),
      ),
      Post(
        id: 3,
        title: 'Hey everyone, this is ilon Maa',
        body:
            'Elon Musk : China will never be able to replicate our technology, see the picture on my post Pfffffft!',
        photo: 'https://img-9gag-fun.9cache.com/photo/a9qAKrW_700bwp.webp',
        createAt: 12,
        isActive: true,
        topicId: 3,
        userId: 3,
        comments: [],
        topic: Topic(
          id: 3,
          name: 'Meme',
          description: 'Meme is Meme',
          suspended: '',
        ),
        user: User(
          id: 3,
          email: 'leonardo@gmail.com',
          username: 'Leonardo DiCaprio',
          password: 'leonardo123',
          photo:
              'https://qph.cf2.quoracdn.net/main-qimg-2c29da64d653f126d5ebb9e67c9a7ad7-pjlq',
          banUntil: '',
          isAdmin: false,
        ),
      ),
    ];
    return posts;
  }

  Future<Iterable<MyTopic>> getTopics() async {
    Iterable<MyTopic> topics = [
      MyTopic(
        id: 1,
        name: 'All',
      ),
      MyTopic(
        id: 2,
        name: 'Programming',
      ),
      MyTopic(
        id: 3,
        name: 'Meme',
      ),
      MyTopic(
        id: 4,
        name: 'Tech',
      ),
      MyTopic(
        id: 5,
        name: 'Sport',
      ),
      MyTopic(
        id: 6,
        name: 'Story',
      ),
      MyTopic(
        id: 7,
        name: 'Series',
      ),
    ];
    return topics;
  }
}
