import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:discussin_mobile/src/screen/post_notification/post_notification_screen.dart';
import 'package:discussin_mobile/src/screen/settings/setting_screen.dart';
import 'package:discussin_mobile/src/screen/sign_in/sign_in_screen.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:discussin_mobile/src/view_model/profile_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  late final ProfileNotifier _viewModel;
  Future<void> _initial() async {
    Future(() {
      _viewModel = ref.read(profileViewModel);
      _viewModel.getUser();
    });
  }

  @override
  void initState() {
    _initial();
    super.initState();
  }

  Widget prviewImage(String imageUrl) {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(profileViewModel);
        if (viewModel.xFile == null) {
          return ClipRRect(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const SizedBox(
                width: 120,
                height: 120,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: yellow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(60),
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
          );
        } else {
          return CircleAvatar(
            backgroundImage: FileImage(File(viewModel.xFile!.path)),
            radius: 60,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: primaryBlue),
        title: Row(
          children: const [
            TextPro(
              'Profile',
              color: primaryBlue,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        backgroundColor: yellow,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostNotificationScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: deepBlue,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignInScreen();
                  },
                ),
              );
              ref.read(profileViewModel).removeToken();
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final viewModel = ref.watch(profileViewModel);
              if (viewModel.xFile == null) {
                return const SizedBox.shrink();
              }
              return IconButton(
                onPressed: () {
                  viewModel.updateUser();
                  viewModel.setXFile(null);
                  viewModel.getUser();
                },
                icon: const Icon(Icons.update),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: editprofile(),
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const TextPro(
            "Choose Profile photo",
            fontSize: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _startCamera,
                icon: const Icon(Icons.camera),
              ),
              const TextPro("Camera"),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: _startGallery,
                icon: const Icon(Icons.image),
              ),
              const TextPro("Gallery")
            ],
          )
        ],
      ),
    );
  }

  void _startCamera() async {
    Navigator.pop(context);
    final image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 500,
      maxWidth: 500,
    );

    if (image != null && mounted) {
      _viewModel.setXFile(image);
    }
  }

  void _startGallery() async {
    Navigator.pop(context);
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 500,
      maxWidth: 500,
    );

    if (image != null && mounted) {
      _viewModel.setXFile(image);
    }
  }

  Widget editprofile() {
    final viewModel = ref.watch(profileViewModel);
    final user = viewModel.user;

    switch (viewModel.actionState) {
      case StateAction.none:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: prviewImage(user!.photo),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(100, 110, 0, 0),
                        width: 45,
                        height: 35,
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 22,
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (builder) => bottomsheet(),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextPro(
                          user.username,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        const Text("Student Collage"),
                        Row(
                          children: const [
                            Text("Followers : 25"),
                            SizedBox(width: 15),
                            Text("Following : 25")
                          ],
                        ),
                        const Text("Joined Since 2018")
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 360,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: primaryBlue,
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                height: 55,
                width: 350,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  highlightColor:
                      const Color.fromARGB(255, 109, 118, 125).withOpacity(0.4),
                  splashColor:
                      const Color.fromARGB(255, 179, 207, 180).withOpacity(0.5),
                  onTap: () {},
                  child: SizedBox(
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.comment_bank_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Discuss created",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 1,
                color: Colors.black45,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: SizedBox(
                height: 55,
                width: 350,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  highlightColor:
                      const Color.fromARGB(255, 109, 118, 125).withOpacity(0.4),
                  splashColor:
                      const Color.fromARGB(255, 179, 207, 180).withOpacity(0.5),
                  onTap: () {},
                  child: SizedBox(
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.comment_bank_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Discuss that you follow",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 1,
                color: Colors.black45,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                height: 55,
                width: 350,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  highlightColor:
                      const Color.fromARGB(255, 109, 118, 125).withOpacity(0.4),
                  splashColor:
                      const Color.fromARGB(255, 179, 207, 180).withOpacity(0.5),
                  onTap: () {},
                  child: SizedBox(
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.edit_note,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Draft",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 1,
                color: Colors.black45,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: SizedBox(
                height: 55,
                width: 350,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  highlightColor:
                      const Color.fromARGB(255, 109, 118, 125).withOpacity(0.4),
                  splashColor:
                      const Color.fromARGB(255, 179, 207, 180).withOpacity(0.5),
                  onTap: () {},
                  child: SizedBox(
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.settings_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Setting",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 1,
                color: Colors.black45,
              ),
            ),
          ],
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
