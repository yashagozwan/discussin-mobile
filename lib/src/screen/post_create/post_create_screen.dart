import 'dart:io';

import 'package:discussin_mobile/src/util/colors.dart';
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
  final ImagePicker imagePicker = ImagePicker();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late final PostCreateNotifier viewModel;

  Future<void> _initial() async {
    Future(() {
      viewModel = ref.read(postCreateViewModel);
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
    _descriptionController.dispose();
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
            onPressed: () {},
            child: const TextPro(
              'Discuss.In',
              color: deepBlue,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
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
                  color: Colors.white,
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
              return DropdownButton(
                dropdownColor: Colors.transparent,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                icon: const Icon(
                  Icons.group,
                  color: Colors.white,
                ),
                elevation: 0,
                value: viewModel.topic,
                items: [
                  ...viewModel.topics.map(
                    (topic) => DropdownMenuItem(
                      value: topic,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCCD9F9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextPro(topic),
                      ),
                    ),
                  )
                ],
                onChanged: (value) {
                  if (value != null) {
                    viewModel.setTopic(value);
                  }
                },
              );
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
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.multiline,
            controller: _descriptionController,
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

    final image = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (image != null && mounted) {
      viewModel.setXFile(image);
    }
  }

  void _startGallery() async {
    Navigator.pop(context);

    final image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null && mounted) {
      viewModel.setXFile(image);
    }
  }
}
