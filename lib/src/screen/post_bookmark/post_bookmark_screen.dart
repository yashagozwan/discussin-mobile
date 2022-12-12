import 'package:cached_network_image/cached_network_image.dart';
import 'package:discussin_mobile/src/screen/post_detail/post_detail_screen.dart';
import 'package:discussin_mobile/src/screen/post_notification/post_notification_screen.dart';
import 'package:discussin_mobile/src/view_model/post_bookmark_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class PostBookmarkScreen extends ConsumerStatefulWidget {
  const PostBookmarkScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostBookmarkScreenState();
}

class _PostBookmarkScreenState extends ConsumerState<PostBookmarkScreen> {
  late PostBookmarkNotifier viewModel;

  Future<void> _initial() async {
    Future(() {
      final viewModel = ref.read(bookmarkViewModel);
      viewModel.getBookmark();
    });
  }

  @override
  void initState() {
    _initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostNotificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 660,
              child: _buildPostBookmark(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostBookmark() {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(bookmarkViewModel);

        final bookmarks = viewModel.bookmarks;
        if (bookmarks.isEmpty) {
          return const Center(
            child: TextPro(
              'There Is No Bookmark',
              fontWeight: FontWeight.w600,
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final bookmark = bookmarks.elementAt(index);
            return Card(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl: '',
                        imageBuilder: (context, imageProvider) => Container(
                          width: 55.0,
                          height: 55.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const SizedBox(
                          width: 55,
                          height: 55,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 55,
                          height: 55,
                          decoration: const BoxDecoration(
                            color: yellow,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                            image: DecorationImage(
                              image: Svg(
                                'assets/svg/avatar.svg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          bookmark.user.username,
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
                      bookmark.post.postTopic,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.bookmark),
                      color: green,
                      onPressed: () {
                        viewModel.deleteBookmark(bookmark.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${bookmark.post.title} Is Deleted From Bookmark List',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            bookmark.post.title,
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
                            bookmark.post.body,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return PostDetailScreen(
                                        postId: bookmark.post.id,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: const TextPro(
                                'Read More',
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(),
          itemCount: bookmarks.length,
        );
      },
    );
  }
}
