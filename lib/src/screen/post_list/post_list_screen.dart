import 'package:discussin_mobile/src/app.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/view_model/post_list_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListScreen extends ConsumerStatefulWidget {
  const PostListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostListScreenState();
}

class _PostListScreenState extends ConsumerState<PostListScreen> {
  Future<void> _initial() async {
    Future(() {
      final viewModel = ref.read(postListViewModel);
      viewModel.loadPosts();
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
      ),
      body: _buildList(),
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
            return Container(
              child: TextPro(post.name),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(),
          itemCount: viewModel.posts.length,
        );
      },
    );
  }
}
