import 'package:discussin_mobile/src/model/post_response_model.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:discussin_mobile/src/view_model/post_list_view_model.dart';
import 'package:discussin_mobile/src/view_model/post_search_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [],
                    ),
                    TextPro(
                      post.title,
                      fontWeight: FontWeight.w600,
                    ),
                    post.photo.isEmpty
                        ? const SizedBox.shrink()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.network(post.photo),
                              )
                            ],
                          ),
                  ],
                ),
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
