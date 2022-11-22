import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostBookmarkScreen extends ConsumerStatefulWidget {
  const PostBookmarkScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostBookmarkScreenState();
}

class _PostBookmarkScreenState extends ConsumerState<PostBookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Post Bookmark'),
      ),
    );
  }
}
