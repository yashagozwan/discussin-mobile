import 'package:cached_network_image/cached_network_image.dart';
import 'package:discussin_mobile/src/screen/sign_in/sign_in_screen.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/view_model/profile_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            onPressed: () {},
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
        ],
      ),
      body: SingleChildScrollView(child: editprofile()),
    );
  }
}

Widget editprofile() {
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
                  child: CachedNetworkImage(
                    imageUrl: 'https://picsum.photos/250?image=9',
                    alignment: Alignment.center,
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      radius: 60,
                    ),
                  ),
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
                    onPressed: () {},
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "John Legend",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
      const SizedBox(
        height: 15,
      ),
      Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 360,
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: const Text("edit Profile")),
        ),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Icon(
              Icons.post_add,
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
      const SizedBox(
        height: 15,
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Divider(
          thickness: 1,
          color: Colors.black45,
        ),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(30, 15, 0, 0),
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
              "Discuss that you joined",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Divider(
          thickness: 1,
          color: Colors.black45,
        ),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(30, 15, 0, 0),
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
      const SizedBox(
        height: 15,
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Divider(
          thickness: 1,
          color: Colors.black45,
        ),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: InkWell(
          splashColor: Colors.black45,
          onTap: () {},
          child: SizedBox(
            width: 335,
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
      const SizedBox(
        height: 15,
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
}
