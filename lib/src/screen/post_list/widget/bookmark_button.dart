import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/view_model/post_bookmark_view_model.dart';
import 'package:discussin_mobile/src/view_model/post_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:discussin_mobile/src/model/post_response_model.dart';

class BookmarkButton extends ConsumerStatefulWidget {
  const BookmarkButton({
    super.key,
    required this.post,
  });
  final PostData post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends ConsumerState<BookmarkButton> {
  bool isSaveable = false;

  void setSaveable(bool value) {
    isSaveable = value;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(postListViewModel);
    return FutureBuilder<bool>(
      future: viewModel.isSaveable(widget.post),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const SizedBox.shrink();
          case ConnectionState.waiting:
            return IconButton(
              onPressed: () {},
              icon: getIcon(isSaveable),
            );
          case ConnectionState.active:
            return const SizedBox.shrink();
          case ConnectionState.done:
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                setSaveable(snapshot.data!);
              }
            }
            return IconButton(
              onPressed: () async {
                if (snapshot.data != null) {
                  if (snapshot.data!) {
                    viewModel.createBookmark(widget.post.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${widget.post.title} Has Been Bookmarked',
                        ),
                      ),
                    );
                  } else {
                    viewModel.deleteSingleBookmark(widget.post.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${widget.post.title} Is Deleted From Bookmark List',
                        ),
                      ),
                    );
                  }
                }
                ref.read(bookmarkViewModel).reloadBookmark();
              },
              icon: getIcon(isSaveable),
            );
        }
      },
    );
  }

  Widget getIcon(bool value) {
    if (value) {
      return const Icon(Icons.bookmark_border);
    } else {
      return const Icon(
        Icons.bookmark,
        color: green,
      );
    }
  }
}
