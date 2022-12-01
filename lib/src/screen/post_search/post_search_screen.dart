import 'package:discussin_mobile/src/screen/post_notification/post_notification_screen.dart';
import 'package:discussin_mobile/src/screen/post_search/widget/card_text.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/view_model/post_search_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostSearchScreen extends ConsumerStatefulWidget {
  const PostSearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostSearchScreenState();
}

class _PostSearchScreenState extends ConsumerState<PostSearchScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: grey),
      title: TextField(
        controller: _searchController,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          color: grey,
        ),
        decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 11,
          ),
          fillColor: const Color(0xFFF3F2F2),
          isDense: true,
          hintText: 'Search by topic or title',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8 * 4),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PostNotificationScreen(),
              ),
            );
          },
          icon: const Icon(Icons.notifications_none),
        )
      ],
    );
  }

  Widget _buildContent() {
    return ListView(
      padding: const EdgeInsets.all(18),
      physics: const BouncingScrollPhysics(),
      children: [
        const TextPro(
          'Trend for you',
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        const SizedBox(height: 8 * 2),
        ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final data = PostSearchNotifier.getTrends().elementAt(index);
            return CardText(
              headTitle: data.headTitle,
              bodyTitle: data.bodyTitle,
              subTitle: data.subTitle,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: PostSearchNotifier.getTrends().length,
        ),
        const SizedBox(height: 16),
        const TextPro(
          'See more trending Topic',
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
