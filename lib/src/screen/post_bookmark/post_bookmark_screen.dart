// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';

class PostBookmarkScreen extends ConsumerStatefulWidget {
  const PostBookmarkScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostBookmarkScreenState();
}

class _PostBookmarkScreenState extends ConsumerState<PostBookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextPro(
          'Bookmark',
          color: primaryBlue,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: yellow,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            color: primaryBlue,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 40,
                child: Center(child: _buildTopicBookmark()),
              ),
            ),
            SizedBox(
              height: 580,
              child: _buildPostBookmark(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicBookmark() {
    return ListView.separated(
      itemBuilder: (context, index) {
        final bookmarkTopics =
            BookmarkTopicChangeNotifier.getBookmarks().elementAt(index);
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // viewModel.getPostByTopic(topic.name);
                // viewModel.setSelectedTopic(topic.name);
              },
              child: Container(
                width: 120,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryBlue,
                    style: BorderStyle.none,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                  color: (bookmarkTopics.name == 'All')
                      ? primaryBlue
                      : Colors.transparent,
                ),
                child: Center(
                  child: TextPro(
                    bookmarkTopics.name,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: (bookmarkTopics.name == 'All')
                        ? Colors.white
                        : primaryBlue,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const VerticalDivider(
        color: Colors.transparent,
        width: 4,
      ),
      itemCount: BookmarkTopicChangeNotifier.getBookmarks().length,
    );
  }

  Widget _buildPostBookmark() {
    return ListView.separated(
      itemBuilder: (context, index) {
        final bookmark = BookmarkChangeNotifier.getBookmarks().elementAt(index);
        return Column(
          children: [
            ListTile(
              leading: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: bookmark.profile,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => const SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/Image-not-available.png'),
                      ),
                    ),
                  ),
                ),
              ),
              title: Row(
                children: [
                  Text(
                    bookmark.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Follow',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                bookmark.topic,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.bookmark),
                color: Colors.black,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      bookmark.title,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      bookmark.decription,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 10, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.thumb_up_alt_outlined),
                            onPressed: () {},
                          ),
                          Text(bookmark.like.toString()),
                          IconButton(
                            icon: const Icon(Icons.thumb_down_alt_outlined),
                            onPressed: () {},
                          ),
                          Text(bookmark.dislike.toString()),
                          IconButton(
                            icon: const Icon(Icons.comment_outlined),
                            onPressed: () {},
                          ),
                          Text(bookmark.comment.toString()),
                        ],
                      ),
                      InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        splashColor: Colors.black12,
                        onTap: () {},
                        child: const SizedBox(
                          width: 100,
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                text: "Read More",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(),
      itemCount: BookmarkChangeNotifier.getBookmarks().length,
    );
  }
}

class BookmarkTopic {
  int id;
  String name;

  BookmarkTopic({
    required this.id,
    required this.name,
  });
}

class BookmarkTopicChangeNotifier extends ChangeNotifier {
  static Iterable<BookmarkTopic> getBookmarks() {
    final bookmarkTopics = [
      BookmarkTopic(
        id: 1,
        name: 'All',
      ),
      BookmarkTopic(
        id: 2,
        name: 'Programming',
      ),
      BookmarkTopic(
        id: 3,
        name: 'Meme',
      ),
      BookmarkTopic(
        id: 4,
        name: 'Tech',
      ),
      BookmarkTopic(
        id: 5,
        name: 'Sport',
      ),
      BookmarkTopic(
        id: 6,
        name: 'Story',
      ),
      BookmarkTopic(
        id: 7,
        name: 'Series',
      ),
    ];
    return bookmarkTopics;
  }
}

final bookmarkTopicViewModel =
    ChangeNotifierProvider<BookmarkTopicChangeNotifier>(
  (ref) {
    return BookmarkTopicChangeNotifier();
  },
);

class Bookmark {
  String username;
  String topic;
  String profile;
  String title;
  String decription;
  String photo;
  int like;
  int dislike;
  int comment;

  Bookmark({
    required this.username,
    required this.topic,
    required this.profile,
    required this.title,
    required this.decription,
    required this.photo,
    required this.like,
    required this.dislike,
    required this.comment,
  });
}

class BookmarkChangeNotifier extends ChangeNotifier {
  static Iterable<Bookmark> getBookmarks() {
    final bookmarks = [
      Bookmark(
        username: 'Pink Guy',
        topic: 'Meme',
        profile:
            'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/a288e946906757.586a393b6be47.jpg',
        title: 'Hey everyone, this is ilon Maa',
        decription:
            'Elon Musk : China will never be able to replicate our technology, see the picture on my post Pfffffft!',
        photo: 'https://img-9gag-fun.9cache.com/photo/a9qAKrW_700bwp.webp',
        like: 120,
        dislike: 15,
        comment: 30,
      ),
      Bookmark(
        username: 'Pink Guy',
        topic: 'Meme',
        profile:
            'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/a288e946906757.586a393b6be47.jpg',
        title: 'Hey everyone, this is ilon Maa',
        decription:
            'Elon Musk : China will never be able to replicate our technology, see the picture on my post Pfffffft!',
        photo: 'https://img-9gag-fun.9cache.com/photo/a9qAKrW_700bwp.webp',
        like: 120,
        dislike: 15,
        comment: 30,
      ),
      Bookmark(
        username: 'Pink Guy',
        topic: 'Meme',
        profile:
            'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/a288e946906757.586a393b6be47.jpg',
        title: 'Hey everyone, this is ilon Maa',
        decription:
            'Elon Musk : China will never be able to replicate our technology, see the picture on my post Pfffffft!',
        photo: 'https://img-9gag-fun.9cache.com/photo/a9qAKrW_700bwp.webp',
        like: 120,
        dislike: 15,
        comment: 30,
      ),
    ];
    return bookmarks;
  }
}

final bookmarkViewModel = ChangeNotifierProvider<BookmarkChangeNotifier>(
  (ref) {
    return BookmarkChangeNotifier();
  },
);
