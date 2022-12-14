import 'package:cached_network_image/cached_network_image.dart';
import 'package:discussin_mobile/src/screen/post_detail/widget/comment_list.dart';
import 'package:discussin_mobile/src/screen/post_list/widget/bookmark_button.dart';
import 'package:discussin_mobile/src/service/comment_service.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:discussin_mobile/src/util/time_format.dart';
import 'package:discussin_mobile/src/view_model/post_detail_view_model.dart';
import 'package:discussin_mobile/src/view_model/post_list_view_model.dart';
import 'package:discussin_mobile/src/view_model/profile_view_model.dart';
import 'package:discussin_mobile/src/widget/follow_button.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  final int postId;

  const PostDetailScreen({Key? key, required this.postId}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final _commentController = TextEditingController();
  late PostDetailNotifier viewModel;
  late ProfileNotifier viewModelUser;

  Future<void> _initial() async {
    Future(() {
      viewModel = ref.read(postDetailViewModel);
      viewModelUser = ref.read(profileViewModel);
      viewModel.getPostById(widget.postId);
      viewModel.getCommentById(widget.postId);
      viewModelUser.getUser();
    });
  }

  @override
  void initState() {
    _initial();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: _buildPostDetail(),
      ),
    );
  }

  Widget _buildPostDetail() {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(postDetailViewModel);
        final viewModelUser = ref.watch(profileViewModel);
        final user = viewModelUser.user;
        final post = viewModel.post;
        switch (viewModel.actionState) {
          case StateAction.none:
            if (post == null) return const SizedBox.shrink();

            return Column(
              children: [
                ListTile(
                  leading: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: post.user.photo,
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
                        post.user.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: FollowButton(post: post),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      TextPro(
                        post.topic.name,
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const TextPro(
                        '-',
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextPro(
                        timeFormat(post.createdAt),
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ],
                  ),
                  trailing: BookmarkButton(post: post),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                      post.photo.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CachedNetworkImage(
                                imageUrl: post.photo.toString(),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 220,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => const SizedBox(
                                  height: 220,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 220,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Image-not-available.png'),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          post.body,
                          textAlign: TextAlign.justify,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.thumb_up_alt_outlined),
                            onPressed: () {
                              ref
                                  .read(postListViewModel)
                                  .doLikePost(widget.postId);
                              viewModel.doLikePost(widget.postId);
                            },
                          ),
                          Text(
                            post.count.like.toString(),
                          ),
                          IconButton(
                            icon: const Icon(Icons.thumb_down_alt_outlined),
                            onPressed: () {
                              ref
                                  .read(postListViewModel)
                                  .doDislikePost(widget.postId);
                              viewModel.doDislikePost(widget.postId);
                            },
                          ),
                          Text(
                            post.count.dislike.toString(),
                          ),
                          IconButton(
                            icon: const Icon(Icons.comment_outlined),
                            onPressed: () {},
                          ),
                          Text(
                            post.count.comment.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: user?.photo ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 40,
                      height: 40,
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
                  title: TextFormField(
                    controller: _commentController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        isDense: true,
                        hintText: 'Leave Comment',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            width: 0,
                          ),
                        ),
                        suffixIcon: Consumer(
                          builder: (context, ref, child) {
                            final viewModel = ref.watch(postDetailViewModel);
                            switch (viewModel.stateActionComment) {
                              case StateAction.none:
                                return IconButton(
                                  onPressed: () async {
                                    await viewModel.createComment(
                                      post.id,
                                      CommentModel(
                                        body: _commentController.text,
                                      ),
                                    );

                                    _commentController.clear();
                                    ref.read(postListViewModel).getAllPost();
                                  },
                                  icon: const Icon(Icons.send),
                                );
                              case StateAction.loading:
                                return Transform.scale(
                                  scale: 0.5,
                                  child: const CircularProgressIndicator(),
                                );
                              case StateAction.error:
                                return const SizedBox.shrink();
                            }
                          },
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final viewModel = ref.watch(postDetailViewModel);
                    final comments = viewModel.comments;
                    switch (viewModel.actionState) {
                      case StateAction.none:
                        if (comments.isEmpty) {
                          return Center(
                            child: SizedBox(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  TextPro('There Is No Comment'),
                                ],
                              ),
                            ),
                          );
                        }
                        return CommentList(
                          comments: comments,
                        );
                      case StateAction.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );

                      case StateAction.error:
                        return const SizedBox.shrink();
                    }
                  },
                )
              ],
            );

          case StateAction.loading:
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );

          case StateAction.error:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
