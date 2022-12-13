import 'package:cached_network_image/cached_network_image.dart';
import 'package:discussin_mobile/src/model/post_response_model.dart';
import 'package:discussin_mobile/src/screen/post_detail/post_detail_screen.dart';
import 'package:discussin_mobile/src/screen/post_list/widget/bookmark_button.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:discussin_mobile/src/util/time_format.dart';
import 'package:discussin_mobile/src/view_model/post_list_view_model.dart';
import 'package:discussin_mobile/src/view_model/post_search_view_model.dart';
import 'package:discussin_mobile/src/widget/follow_button.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SectionList extends ConsumerStatefulWidget {
  const SectionList({Key? key}) : super(key: key);

  @override
  ConsumerState<SectionList> createState() => _SectionListState();
}

class _SectionListState extends ConsumerState<SectionList> {
  late final PostListNotifier _postListViewModelRead;
  late final PostSearchNotifier _postSearchViewModelRead;

  Future<void> _initial() async {
    Future(() {
      // Initial viewModel
      _postListViewModelRead = ref.read(postListViewModel);
      _postSearchViewModelRead = ref.read(postSearchViewModel);

      // Check if text field search is empty
      if (_postSearchViewModelRead.inputSearch.isEmpty) {
        _postListViewModelRead.getPostsInSearch();
      }

      // Use viewModel
      _postSearchViewModelRead.addListener(() {
        _postListViewModelRead.searchPost(
          _postSearchViewModelRead.inputSearch,
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initial();
  }

  @override
  Widget build(BuildContext context) {
    return renderListPostSearch();
  }

  Widget renderListPostSearch() {
    final viewModel = ref.watch(postListViewModel);
    final posts = viewModel.postsInSearch;

    switch (viewModel.stateActionSearch) {
      case StateAction.none:
        if (posts.isEmpty) {
          return const Center(
            child: TextPro(
              'Post Is Not Found',
              fontSize: 24,
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final post = posts.elementAt(index);
            // Todo dari sini edit nya
            return Card(
              child: Column(
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
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
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
                    ),
                    subtitle: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TextPro(
                            post.topic.name,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const TextPro(
                            '-',
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextPro(
                            timeFormat(post.createdAt),
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),
                    trailing: BookmarkButton(
                      post: post,
                    ),
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
                            ? Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: post.photo,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Align(
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                                      return PostDetailScreen(postId: post.id);
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
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(),
          itemCount: posts.length,
        );
      case StateAction.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case StateAction.error:
        return const SizedBox.shrink();
    }
  }
}
