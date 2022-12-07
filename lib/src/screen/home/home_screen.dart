import 'package:discussin_mobile/src/screen/post_bookmark/post_bookmark_screen.dart';
import 'package:discussin_mobile/src/screen/post_create/post_create_screen.dart';
import 'package:discussin_mobile/src/screen/post_list/post_list_screen.dart';
import 'package:discussin_mobile/src/screen/post_search/post_search_screen.dart';
import 'package:discussin_mobile/src/screen/profile/profile_screen.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/view_model/home_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
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
    SizedBox.shrink(),
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
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildBottomNavigation(BuildContext ctx) {
    return Consumer(
      builder: (_, ref, child) {
        final viewModel = ref.watch(homeViewModel);
        final index = viewModel.selectedIndexScreen;
        final setIndex = viewModel.setSelectedIndexScreen;

        return BottomNavigationBar(
          backgroundColor: yellow,
          onTap: (value) {
            switch (value) {
              case 0:
                return setIndex(value);
              case 1:
                return setIndex(value);
              case 2:
                showModalBottomSheet(
                  useRootNavigator: true,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  barrierColor: Colors.transparent,
                  backgroundColor: const Color(0xFFAABFF5),
                  elevation: 0,
                  context: ctx,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      height: 120,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 30,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8 * 6,
                                  ),
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black26,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const PostCreateScreen();
                                      },
                                    ),
                                  );
                                },
                                child: const TextPro('Create a Discuss?'),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.add_photo_alternate,
                                        color: deepBlue,
                                      ),
                                      TextPro(
                                        'Add Photo',
                                        color: deepBlue,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.file_present_outlined,
                                        color: deepBlue,
                                      ),
                                      TextPro(
                                        'Add File',
                                        color: deepBlue,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
                break;
              case 3:
                return setIndex(value);
              case 4:
                return setIndex(value);
            }
          },
          currentIndex: index,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: primaryBlue,
          unselectedItemColor: grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.create),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: '',
            ),
          ],
        );
      },
    );
  }
}
