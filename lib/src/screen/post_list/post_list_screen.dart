import 'package:cached_network_image/cached_network_image.dart';
import 'package:discussin_mobile/src/screen/post_notification/post_notification_screen.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/view_model/post_list_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../post_detail/post_detail_screen.dart';

class PostListScreen extends ConsumerStatefulWidget {
  const PostListScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostListScreenState();
}

class _PostListScreenState extends ConsumerState<PostListScreen> {
  Future<void> _initial() async {
    Future(() {
      final viewModel = ref.read(postListViewModel);
      viewModel.getAllPost();
      viewModel.getTopics();
    });
  }

  @override
  void initState() {
    super.initState();
    _initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextPro(
          'Discuss.In',
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 40,
                child: Center(child: _buildTopicList()),
              ),
            ),
            SizedBox(
              height: 580,
              child: _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicList() {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(postListViewModel);
        final topics = viewModel.topics;
        return ListView.separated(
          itemBuilder: (context, index) {
            final topic = topics.elementAt(index);
            return Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    viewModel.setSelectedTopic(topic.name);
                    viewModel.getPostByTopic(topic.name);
                  },
                  child: Consumer(
                    builder: (context, ref, child) {
                      final viewModel = ref.watch(postListViewModel);
                      final selectedTopic = viewModel.selectedTopic;
                      return Container(
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
                          color: (topic.name == selectedTopic)
                              ? primaryBlue
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: TextPro(
                            topic.name,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: (topic.name == selectedTopic)
                                ? Colors.white
                                : primaryBlue,
                          ),
                        ),
                      );
                    },
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
          itemCount: topics.length,
        );
      },
    );
  }

  Widget _buildList() {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(postListViewModel);
        final posts = viewModel.posts;
        return ListView.separated(
          itemBuilder: (context, index) {
            final post = posts.elementAt(index);
            return Column(
              children: [
                ListTile(
                  leading: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://cdna.artstation.com/p/assets/images/images/038/652/364/4k/joe-parente-joji-pink-guy-comp-05.jpg?1623691236',
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
                              image: NetworkImage(
                                'https://cdna.artstation.com/p/assets/images/images/038/652/364/4k/joe-parente-joji-pink-guy-comp-05.jpg?1623691236',
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        post.user.username,
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
                  subtitle: Row(
                    children: [
                      Text(
                        post.topic.name,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        '-',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        '3 Min Ago',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.bookmark_outline),
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
                          post.title,
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
                          post.body,
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
                              Text(post.count.like.toString()),
                              IconButton(
                                icon: const Icon(Icons.thumb_down_alt_outlined),
                                onPressed: () {},
                              ),
                              Text(post.count.dislike.toString()),
                              IconButton(
                                icon: const Icon(Icons.comment_outlined),
                                onPressed: () {},
                              ),
                              Text(post.count.comment.toString()),
                            ],
                          ),
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            splashColor: Colors.black12,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PostDetailScreen(post: post);
                                  },
                                ),
                              );
                            },
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
          itemCount: posts.length,
        );
      },
    );
  }
}
