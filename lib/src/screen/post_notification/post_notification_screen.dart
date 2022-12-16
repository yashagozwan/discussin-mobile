import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:discussin_mobile/src/view_model/post_notification_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostNotificationScreen extends ConsumerStatefulWidget {
  const PostNotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PostNotificationScreenState();
}

class _PostNotificationScreenState
    extends ConsumerState<PostNotificationScreen> {
  late PostNotificationNotifier viewModel;

  Future<void> _initial() async {
    Future(() async {
      viewModel = ref.read(postNotificationViewModel);
      viewModel.getNotifications();
    });
  }

  @override
  void initState() {
    super.initState();
    _initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _listTitle(title: 'New'),
          _listNotification(),
          _listTitle(title: 'Yesterday'),
          _listNotification(),
        ],
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
        'Discuss.In',
        color: primaryBlue,
      ),
      backgroundColor: yellow,
      elevation: 0,
    );
  }

  Widget _listTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: TextPro(
        title,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }

  Widget _listNotification() {
    final viewModel = ref.watch(postNotificationViewModel);
    final notifications = viewModel.notifications;

    switch (viewModel.actionState) {
      case StateAction.none:
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final notification = notifications.elementAt(index);
            final username = notification.username;
            final topic = notification.topic;

            return ListTile(
              tileColor: const Color(0xFFCCD9F9),
              leading: const CircleAvatar(),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: username,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(text: ' replied your comment on '),
                    TextSpan(
                      text: topic,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              subtitle: const TextPro('3 Hours ago'),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 4),
          itemCount: notifications.length,
        );
      case StateAction.loading:
        return const SizedBox.shrink();
      case StateAction.error:
        return const SizedBox.shrink();
    }
  }
}
