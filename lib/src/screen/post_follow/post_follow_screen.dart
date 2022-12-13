import 'package:cached_network_image/cached_network_image.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/view_model/post_follow_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class PostFollowScreen extends ConsumerStatefulWidget {
  const PostFollowScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostFollowScreenState();
}

class _PostFollowScreenState extends ConsumerState<PostFollowScreen> {
  late PostFollowNotifier viewModel;

  Future<void> _initial() async {
    Future(() {
      final viewModel = ref.read(postFollowViewModel);
      viewModel.getFollow();
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
        automaticallyImplyLeading: false,
        title: const TextPro(
          'Followed Discuss',
          color: primaryBlue,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 660,
              child: _buildPostFollow(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostFollow() {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(postFollowViewModel);
        final follows = viewModel.follows;

        if (follows.isEmpty) {
          return const Center(
            child: TextPro(
              'You Not Follow Any Discusss',
              fontWeight: FontWeight.w600,
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final follow = follows.elementAt(index);
            return Card(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 10, 0, 10),
                    child: ListTile(
                      leading: ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: '',
                          imageBuilder: (context, imageProvider) => Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => const SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 50,
                            height: 50,
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
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              follow.user.username,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                            size: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Topic',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            follow.post.title,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            follow.post.body,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              splashColor: Colors.black12,
                              onTap: () {
                                viewModel.deleteFollow(follow.post.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${follow.post.title} Is Deleted From Followed Discuss',
                                    ),
                                  ),
                                );
                              },
                              child: const SizedBox(
                                width: 60,
                                child: Center(
                                  child: Text.rich(
                                    TextSpan(
                                      text: "Delete",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: red,
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
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(),
          itemCount: follows.length,
        );
      },
    );
  }
}
