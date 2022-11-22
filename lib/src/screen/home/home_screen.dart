import 'package:discussin_mobile/src/screen/post_bookmark/post_bookmark_screen.dart';
import 'package:discussin_mobile/src/screen/post_create/post_create_screen.dart';
import 'package:discussin_mobile/src/screen/post_list/post_list_screen.dart';
import 'package:discussin_mobile/src/screen/post_search/post_search_screen.dart';
import 'package:discussin_mobile/src/screen/profile/profile_screen.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final Iterable<Widget> _screens = const [
    PostListScreen(),
    PostSearchScreen(),
    PostCreateScreen(),
    PostBookmarkScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final viewModel = ref.watch(homeViewModel);
          return _screens.elementAt(viewModel.selectedIndexScreen);
        },
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final viewModel = ref.watch(homeViewModel);
          return BottomNavigationBar(
            currentIndex: viewModel.selectedIndexScreen,
            onTap: viewModel.setSelectedIndexScreen,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
                backgroundColor: yellow,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
                backgroundColor: yellow,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.create),
                label: '',
                backgroundColor: yellow,
              ),
              BottomNavigationBarItem(
                icon: viewModel.selectedIndexScreen == 3
                    ? const Icon(Icons.bookmark)
                    : const Icon(Icons.bookmark_outline),
                label: '',
                backgroundColor: yellow,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: '',
                backgroundColor: yellow,
              ),
            ],
            selectedItemColor: primaryBlue,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: grey,
          );
        },
      ),
    );
  }
}
