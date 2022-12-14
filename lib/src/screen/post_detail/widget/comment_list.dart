import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:discussin_mobile/src/model/comment_response_model.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/view_model/post_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class CommentList extends ConsumerStatefulWidget {
  final Iterable<CommentData> comments;
  const CommentList({super.key, required this.comments});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentListState();
}

class _CommentListState extends ConsumerState<CommentList> {
  late Iterable<CommentData> comments;

  Future<void> _initial() async {
    comments = widget.comments;
    Future(() {});
  }

  @override
  void initState() {
    _initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(postDetailViewModel);
        final comments = viewModel.comments;
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments.elementAt(index);
            return CommentTreeWidget<Comment, Comment>(
              Comment(
                avatar: comment.user.photo,
                userName: comment.user.username,
                content: comment.body,
              ),
              const [],
              treeThemeData: const TreeThemeData(
                lineColor: Colors.transparent,
                lineWidth: 3,
              ),
              avatarRoot: (context, data) => PreferredSize(
                preferredSize: const Size.fromRadius(18),
                child: CachedNetworkImage(
                  imageUrl: '${data.avatar}',
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
                      borderRadius: BorderRadius.all(Radius.circular(100)),
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
              contentRoot: (context, data) {
                return Padding(
                  padding: const EdgeInsets.only(left: 9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.userName}',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${data.content}',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
