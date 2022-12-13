import 'package:discussin_mobile/src/model/post_response_model.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/view_model/post_follow_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowButton extends ConsumerStatefulWidget {
  const FollowButton({
    super.key,
    required this.post,
  });
  final PostData post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowButtonState();
}

class _FollowButtonState extends ConsumerState<FollowButton> {
  bool isFollowable = false;

  void setFollowable(bool value) {
    isFollowable = value;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(postFollowViewModel);
    return FutureBuilder<bool>(
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const SizedBox.shrink();
          case ConnectionState.waiting:
            return InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              splashColor: Colors.black12,
              onTap: () {},
              child: SizedBox(
                width: 60,
                child: Center(
                  child: getText(isFollowable),
                ),
              ),
            );
          case ConnectionState.active:
            return const SizedBox.shrink();
          case ConnectionState.done:
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                setFollowable(snapshot.data!);
              }
            }
            return InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              splashColor: Colors.black12,
              onTap: () {
                if (snapshot.data != null) {
                  if (snapshot.data!) {
                    viewModel.createFollow(widget.post.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${widget.post.title} Followed',
                        ),
                      ),
                    );
                  } else {
                    viewModel.deleteFollow(widget.post.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${widget.post.title} Unfollowed',
                        ),
                      ),
                    );
                  }
                }
                ref.read(postFollowViewModel).reloadFollow();
              },
              child: SizedBox(
                width: 60,
                child: Center(
                  child: getText(isFollowable),
                ),
              ),
            );
        }
      },
    );
  }

  Widget getText(bool value) {
    if (value) {
      return const Text.rich(
        TextSpan(
          text: "Follow",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: primaryBlue,
          ),
        ),
      );
    } else {
      return const Text.rich(
        TextSpan(
          text: "Followed",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: primaryBlue,
          ),
        ),
      );
    }
  }
}
