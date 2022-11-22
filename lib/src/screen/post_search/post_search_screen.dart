import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostSearchScreen extends ConsumerStatefulWidget {
  const PostSearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostSearchScreenState();
}

class _PostSearchScreenState extends ConsumerState<PostSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Post Search Screen'),
      ),
    );
  }
}
