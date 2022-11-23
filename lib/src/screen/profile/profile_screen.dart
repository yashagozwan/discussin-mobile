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
            SizedBox(width: 280),
            Icon(Icons.notifications_sharp,
            
            )
          ],
        ),
        backgroundColor: yellow,
        elevation: 0,
      ),
    );
  }
}
