import 'package:discussin_mobile/src/screen/post_detail/post_detail_screen.dart';
import 'package:discussin_mobile/src/screen/post_search/widget/section_list.dart';
import 'package:discussin_mobile/src/view_model/post_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../util/colors.dart';
import '../../view_model/post_search_view_model.dart';
import '../../widget/text_pro.dart';
import '../post_notification/post_notification_screen.dart';
import 'widget/card_text.dart';

class PostSearchScreen extends ConsumerStatefulWidget {
  const PostSearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostSearchScreenState();
}

class _PostSearchScreenState extends ConsumerState<PostSearchScreen> {
  final _searchController = TextEditingController();
  final _onFocus = FocusNode();
  late final PostSearchNotifier _viewModel;
  late PostListNotifier viewModel;

  Future<void> _initial() async {
    Future(() {
      _viewModel = ref.read(postSearchViewModel);
      _searchController.text = _viewModel.inputSearch;

      viewModel = ref.read(postListViewModel);
      viewModel.getTrendingPost();
    });

    _searchController.addListener(() {
      _viewModel.setInputSearch(_searchController.text);
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
      backgroundColor: const Color(0xFFF8F8FA),
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _onFocus.dispose();
    _searchController.dispose();
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: grey),
      title: TextField(
        focusNode: _onFocus,
        controller: _searchController,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          color: grey,
        ),
        decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 11,
          ),
          fillColor: const Color(0xFFF3F2F2),
          isDense: true,
          hintText: 'Search by topic or title',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8 * 4),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PostNotificationScreen(),
              ),
            );
          },
          icon: const Icon(Icons.notifications_none),
        )
      ],
    );
  }

  Widget _buildContent() {
    final viewModel = ref.watch(postSearchViewModel);
    final inputSearch = viewModel.inputSearch;

    // Show another widget if field is not empty
    if (inputSearch.isNotEmpty) {
      return const SectionList();
    }

    return ListView(
      padding: const EdgeInsets.all(18),
      physics: const BouncingScrollPhysics(),
      children: [
        const TextPro(
          'Trending Today',
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        const SizedBox(height: 8 * 2),
        Consumer(
          builder: (context, ref, child) {
            final viewModel = ref.watch(postListViewModel);
            final posts = viewModel.posts;
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final trend = posts.elementAt(index);
                return CardText(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PostDetailScreen(postId: trend.id);
                        },
                      ),
                    );
                  },
                  headTitle: 'Trending In ${trend.topic.name}',
                  bodyTitle: trend.title,
                  subTitle: '${trend.count.like} Likes',
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: posts.length,
            );
          },
        ),
        const SizedBox(height: 16),
        const TextPro(
          'See more trending Topic',
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
