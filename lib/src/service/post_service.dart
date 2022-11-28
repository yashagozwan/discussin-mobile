import 'package:discussin_mobile/src/model/post_model.dart';
import 'package:discussin_mobile/src/model/topic_model.dart';

class PostService {
  Future<Iterable<Post>> getPosts() async {
    Iterable<Post> posts = [
      Post(
        id: 10,
        name: 'Do you have unforgettable climbing experience?',
        description:
            'It all started back in 2008. I was in my second year of university, and one night my friend Megan decided that she wanted to go to a lecture about mountains as a ploy to meet hot guys, and she dragged me alone, It all started back in 2008. I was in my second year of university, and one night my friend Megan decided that she wanted to go to a lecture about mountains as a ploy to meet hot guys, and she dragged me alonoe. To see Everest, one must go to a lookout called Tiger Hill, thirteen miles to the southeast.',
        imageUrl: 'https://wallpaperaccess.com/full/223237.jpg',
        userId: 12,
        topicId: 1,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        isActive: true,
      ),
      Post(
        id: 11,
        name: 'Did you know about Breakdance Lizard?',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        imageUrl:
            'https://images.pling.com/img/00/00/61/26/90/1536184/6337a702d0cd417543a99905b75ea7f0ce0332a8e2bd53fae2468b8e0ca92826bb0e.jpg',
        userId: 12,
        topicId: 2,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        isActive: true,
      ),
      Post(
        id: 12,
        name: 'Talk about Flutter',
        description:
            'Flutter is Google portable UI toolkit for crafting beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.',
        imageUrl:
            'https://www.kibrispdr.org/data/748/nature-wallpaper-hd-1080p-27.jpg',
        userId: 12,
        topicId: 3,
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
      ),
      Topic(
        id: 4,
        name: 'Tech',
      ),
      Topic(
        id: 5,
        name: 'Sport',
      ),
      Topic(
        id: 6,
        name: 'Programming',
      ),
      Topic(
        id: 7,
        name: 'Series',
      ),
    ];
    return topics;
  }
}
