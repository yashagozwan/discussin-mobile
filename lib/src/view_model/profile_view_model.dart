import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/model/user_response_model.dart';
import 'package:discussin_mobile/src/service/cloudinary_service.dart';
import 'package:discussin_mobile/src/service/shared_service.dart';
import 'package:discussin_mobile/src/service/user_service.dart';
import 'package:discussin_mobile/src/util/error_message.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileNotifier extends ChangeNotifier with FiniteState, ErrorMessage {
  final _userService = UserService();
  final _cloudinaryService = CloudinaryService();
  final _sharedService = SharedService();

  User? get user => _user;
  User? _user;

  XFile? get xFile => _xFile;
  XFile? _xFile;

  void setXFile(XFile? newXFile) {
    _xFile = newXFile;
    notifyListeners();
  }

  Future<void> getUser() async {
    setStateAction(StateAction.loading);
    try {
      final result = await _userService.getUser();
      _user = result.data;

      notifyListeners();
      setStateAction(StateAction.none);
    } on DioError catch (error) {
      setStateAction(StateAction.error);
      print(error.response?.data);
    }
  }

  Future<bool> removeToken() async {
    _user = null;
    notifyListeners();
    return await _sharedService.removeToken();
  }

  Future<bool> updateUser() async {
    setStateAction(StateAction.loading);
    try {
      final userUpdate = UserUpdate(
        username: _user?.username ?? "",
        photo: _user?.photo ?? "",
      );

      if (xFile != null) {
        final imageUrl = await _cloudinaryService.uploadImage(xFile!);
        userUpdate.photo = imageUrl ?? '';
      }

      await _userService.updateUser(userUpdate);
      return true;
    } on DioError catch (error) {
      errorMessage = error.response?.data['message'];
      return false;
    }
  }
}

final profileViewModel =
    ChangeNotifierProvider<ProfileNotifier>((ref) => ProfileNotifier());
