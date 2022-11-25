import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/model/sign_in_model.dart';
import 'package:discussin_mobile/src/service/auth_service.dart';
import 'package:discussin_mobile/src/service/shared_service.dart';
import 'package:discussin_mobile/src/util/error_message.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInNotifier extends ChangeNotifier with FiniteState, ErrorMessage {
  final _authService = AuthService();
  final _sharedService = SharedService();

  Future<bool> signIn(SignIn signIn) async {
    setStateAction(StateAction.loading);
    try {
      final res = await _authService.login(signIn);
      final result = await _sharedService.saveToken(res.data.token);
      setErrorMessage(null);
      setStateAction(StateAction.none);
      return result;
    } on DioError catch (error) {
      setErrorMessage(error.response?.data['message']);
      setStateAction(StateAction.error);
      return false;
    }
  }
}

final signInViewModel =
    ChangeNotifierProvider<SignInNotifier>((ref) => SignInNotifier());
