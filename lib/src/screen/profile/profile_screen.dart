import 'package:cached_network_image/cached_network_image.dart';
import 'package:discussin_mobile/src/util/colors.dart';
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
        title: Row(children: const [
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
            icon: new Icon(Icons.notifications_none_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: editprofile(),
    );
  }
}

Widget editprofile() {
  return Column(children: [
          Stack(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
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
                margin: EdgeInsets.fromLTRB(110, 110, 0, 0),
                width: 45,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
              ),
              child: IconButton(
                  iconSize: 22,
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              )
            ],
          )
        ]);
}