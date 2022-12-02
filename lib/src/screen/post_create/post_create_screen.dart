import 'dart:io';

import 'package:discussin_mobile/src/screen/home/home_screen.dart';
import 'package:discussin_mobile/src/service/post_service.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:discussin_mobile/src/view_model/home_view_model.dart';
import 'package:discussin_mobile/src/view_model/post_create_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PostCreateScreen extends ConsumerStatefulWidget {
  const PostCreateScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PostCreateScreenState();
  }
}

class _PostCreateScreenState extends ConsumerState<PostCreateScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  late final PostCreateNotifier _viewModel;

  Future<void> _initial() async {
    Future(() {
      _viewModel = ref.read(postCreateViewModel);
      _viewModel.getTopics();

      _titleController.text = _viewModel.title;
      _bodyController.text = _viewModel.body;

      _titleController.addListener(() {
        _viewModel.setTitle(_titleController.text);
      });

      _bodyController.addListener(() {
        _viewModel.setBody(_bodyController.text);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initial();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _bodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 16),
          _buildCurrentAccount(),
          const SizedBox(height: 16),
          _buildFormAndImage(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.clear),
      ),
      iconTheme: const IconThemeData(
        color: Colors.grey,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.black26,
              backgroundColor: yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: _saveAction,
            child: const TextPro(
              'Discuss.In',
              color: deepBlue,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        _resetField(),
      ],
    );
  }

  Widget _resetField() {
    final viewModel = ref.watch(postCreateViewModel);

    if (viewModel.title.isEmpty && viewModel.body.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.black26,
          backgroundColor: yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const TextPro('Clear This Tread?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      viewModel.setTitle('');
                      viewModel.setBody('');
                      viewModel.setXFile(null);
                      _titleController.clear();
                      _bodyController.clear();
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            },
          );
        },
        child: const TextPro(
          'Reset',
          color: deepBlue,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  void _saveAction() async {
    final viewModel = ref.watch(postCreateViewModel);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const TextPro('Publish This Tread?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Consumer(
            builder: (context, ref, child) {
              final viewModel = ref.watch(postCreateViewModel);
              switch (viewModel.actionState) {
                case StateAction.none:
                  return const SizedBox.shrink();
                case StateAction.loading:
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      TextPro('Uploading...'),
                    ],
                  );
                case StateAction.error:
                  return const SizedBox.shrink();
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                final topicName = viewModel.topicName;
                final post = PostModel(
                  title: viewModel.title,
                  body: viewModel.body,
                );

                final result = await viewModel.createPost(topicName, post);
                if (result && mounted) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        const indexPostList = 0;
                        ref
                            .read(homeViewModel)
                            .setSelectedIndexScreen(indexPostList);
                        return const HomeScreen();
                      },
                    ),
                  );
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCurrentAccount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
          ),
          const SizedBox(width: 16),
          Consumer(
            builder: (context, ref, child) {
              final viewModel = ref.watch(postCreateViewModel);
              return DropdownButton(
                dropdownColor: Colors.transparent,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                icon: const Icon(
                  Icons.group,
                  color: Colors.transparent,
                ),
                elevation: 0,
                value: viewModel.visibility,
                items: [
                  DropdownMenuItem(
                    value: 'public',
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCD9F9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.group),
                          SizedBox(width: 8),
                          TextPro('Public'),
                        ],
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'limited',
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCD9F9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.person),
                          SizedBox(width: 8),
                          TextPro('Limited'),
                        ],
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    viewModel.setVisibility(value);
                  }
                },
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final viewModel = ref.watch(postCreateViewModel);

              switch (viewModel.actionState) {
                case StateAction.none:
                  return DropdownButton(
                    focusColor: Colors.transparent,
                    dropdownColor: Colors.transparent,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    icon: const Icon(
                      Icons.group,
                      color: Colors.transparent,
                    ),
                    elevation: 0,
                    value: viewModel.topicName,
                    items: [
                      ...viewModel.topics.map(
                        (topic) => DropdownMenuItem(
                          value: topic.name,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFCCD9F9),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextPro(topic.name),
                          ),
                        ),
                      )
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        viewModel.setTopicName(value);
                      }
                    },
                  );

                case StateAction.loading:
                  return const CircularProgressIndicator();
                case StateAction.error:
                  return const SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildFormAndImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildForm(),
        _imagePreview(),
      ],
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            keyboardType: TextInputType.multiline,
            controller: _titleController,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
            decoration: const InputDecoration(
              hintText: 'Write some title ...',
            ),
            maxLines: null,
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            controller: _bodyController,
            style: const TextStyle(
              height: 1.5,
            ),
            decoration: const InputDecoration(
              hintText: 'Write some content text here ...',
              border: InputBorder.none,
            ),
            maxLines: null,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _imagePreview() {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(postCreateViewModel);
        if (viewModel.xFile != null) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                width: MediaQuery.of(context).size.width,
                child: Image.file(
                  File(viewModel.xFile!.path),
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24 / 2),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        viewModel.setXFile(null);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: deepBlue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget? _buildBottomNavigation() {
    if (ref.watch(postCreateViewModel).xFile == null) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: yellow,
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _showAlertDialog,
                child: const Icon(
                  Icons.image,
                  color: deepBlue,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return null;
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellow,
                    elevation: 0,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _startGallery,
                  child: const Icon(
                    Icons.image,
                    color: deepBlue,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: yellow,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _startCamera,
                  child: const Icon(
                    Icons.camera_alt,
                    color: deepBlue,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
}
