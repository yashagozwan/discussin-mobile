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
    );
  }
}
