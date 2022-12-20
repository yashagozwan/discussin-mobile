import 'package:discussin_mobile/src/screen/sign_in/sign_in_screen.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/view_model/profile_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: editSetting(),
      ),
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
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SizedBox(
            height: 55,
            width: 385,
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
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      TextPro(
                        "Account settings",
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
            width: 385,
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
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      TextPro(
                        "Notification",
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Divider(
            thickness: 1,
            color: Colors.black45,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(35, 15, 0, 0),
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
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SizedBox(
            height: 55,
            width: 385,
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
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      TextPro(
                        "Select Language",
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Divider(
            thickness: 1,
            color: Colors.black45,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(35, 15, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              TextPro(
                "Others",
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
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SizedBox(
            height: 55,
            width: 385,
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
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      TextPro(
                        "About Discuss.In",
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Divider(
            thickness: 1,
            color: Colors.black45,
          ),
        ),
        SizedBox(
          height: 55,
          width: 385,
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
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 20,
                    ),
                    TextPro(
                      "help & support",
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
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
            width: 385,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              highlightColor:
                  const Color.fromARGB(255, 109, 118, 125).withOpacity(0.4),
              splashColor:
                  const Color.fromARGB(255, 179, 207, 180).withOpacity(0.5),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignInScreen();
                    },
                  ),
                  (route) => false,
                );
                ref.read(profileViewModel).removeToken();
              },
              child: SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      TextPro(
                        "Logout",
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
