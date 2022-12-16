import 'package:cached_network_image/cached_network_image.dart';
import 'package:discussin_mobile/src/screen/post_create/post_create_screen.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/view_model/profile_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ShowBottomSheetCreate extends ConsumerStatefulWidget {
  const ShowBottomSheetCreate({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShowBottomSheetCreateState();
}

class _ShowBottomSheetCreateState extends ConsumerState<ShowBottomSheetCreate> {
  late ProfileNotifier viewModel;

  Future<void> _intial() async {
    Future(
      () {
        final viewModel = ref.read(profileViewModel);
        viewModel.getUser();
      },
    );
  }

  @override
  void initState() {
    _intial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(profileViewModel);
        final user = viewModel.user;
        return Container(
          padding: const EdgeInsets.all(20),
          height: 120,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: user?.photo ?? '',
                  imageBuilder: (context, imageProvider) => Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      image: DecorationImage(
                        image: Svg(
                          'assets/svg/avatar.svg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
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
  }
}
