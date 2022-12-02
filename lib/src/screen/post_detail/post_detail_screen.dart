import 'package:cached_network_image/cached_network_image.dart';
import 'package:discussin_mobile/src/model/post_response_model.dart';
import 'package:discussin_mobile/src/screen/post_detail/widget/comment_list.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  final PostData post;
  const PostDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  late PostData post;

  @override
  void initState() {
    super.initState();
    post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const TextPro(
          'Discuss.In',
          color: primaryBlue,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: yellow,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            color: primaryBlue,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 1200,
              child: _buildPostDetail(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostDetail() {
    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            child: CachedNetworkImage(
              imageUrl: '',
              imageBuilder: (context, imageProvider) => Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => const SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(child: CircularProgressIndicator())),
              errorWidget: (context, url, error) => Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Image-not-available.png'),
                  ),
                ),
              ),
            ),
          ),
          title: Row(
            children: const [
              Text(
                'Harry Potter',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Follow',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryBlue,
                  ),
                ),
              ),
            ],
          ),
          subtitle: const Text(
            'Topic',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.bookmark_outline),
            color: Colors.black,
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  post.title,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  post.body,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              post.photo.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: post.photo.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        height: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const SizedBox(
                          height: 220,
                          child: Center(child: CircularProgressIndicator())),
                      errorWidget: (context, url, error) => Container(
                        height: 220,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/Image-not-available.png'),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 10, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up_alt_outlined),
                    onPressed: () {},
                  ),
                  const Text('10'),
                  IconButton(
                    icon: const Icon(Icons.thumb_down_alt_outlined),
                    onPressed: () {},
                  ),
                  const Text('10'),
                  IconButton(
                    icon: const Icon(Icons.comment_outlined),
                    onPressed: () {},
                  ),
                  const Text('10'),
                ],
              ),
            ],
          ),
        ),
        const CommentList()
      ],
    );
  }
}
