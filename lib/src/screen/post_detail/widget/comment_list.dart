import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentList extends ConsumerStatefulWidget {
  const CommentList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentListState();
}

class _CommentListState extends ConsumerState<CommentList> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage('assets/avatar_2.png'),
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
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: CommentTreeWidget<Comment, Comment>(
            Comment(
                avatar: 'null',
                userName: 'null',
                content: 'felangel made felangel/cubit_and_beyond public'),
            [
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content: 'A Dart template generator which helps teams'),
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content:
                      'A Dart template generator which helps teams generator which helps teams generator which helps teams'),
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content: 'A Dart template generator which helps teams'),
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content:
                      'A Dart template generator which helps teams generator which helps teams'),
            ],
            treeThemeData: const TreeThemeData(
              lineColor: Colors.transparent,
            ),
            avatarRoot: (context, data) => const PreferredSize(
              preferredSize: Size.fromRadius(18),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/avatar_2.png'),
              ),
            ),
            avatarChild: (context, data) => const PreferredSize(
              preferredSize: Size.fromRadius(12),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/avatar_1.png'),
              ),
            ),
            contentChild: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'dangngocduc',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${data.content}',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w300, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.grey[700], fontWeight: FontWeight.bold),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 24,
                          ),
                          Text('Reply'),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
            contentRoot: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'dangngocduc',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${data.content}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w300, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.grey[700], fontWeight: FontWeight.bold),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 24,
                          ),
                          Text('Reply'),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
