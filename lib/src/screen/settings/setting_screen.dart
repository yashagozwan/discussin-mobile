import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(child: editSetting())
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme.copyWith(color: primaryBlue),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      title: const TextPro(
        'Settings',
        color: primaryBlue,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: yellow,
      elevation: 0,
    );
  }
  Widget editSetting() {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            TextPro(
              "Application settings",
              fontSize: 18,
              fontWeight: FontWeight.w800,
              
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
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: InkWell(
          splashColor: Colors.black45,
          onTap: () {},
          child: SizedBox(
            width: 345,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                TextPro(
                    "Account settings",
                  fontSize: 18,
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
      Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: InkWell(
          splashColor: Colors.black45,
          onTap: () {},
          child: SizedBox(
            width: 345,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                TextPro(
                    "Notification",
                  fontSize: 18,
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
      Container(
        margin: const EdgeInsets.fromLTRB(35, 10, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            TextPro(
              "Language",
              fontSize: 18,
              fontWeight: FontWeight.w800,
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
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: InkWell(
          splashColor: Colors.black45,
          onTap: () {},
          child: SizedBox(
            width: 345,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                TextPro(
                    "Notification",
                  fontSize: 18,
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
}