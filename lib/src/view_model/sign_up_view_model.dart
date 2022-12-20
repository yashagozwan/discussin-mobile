import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/model/sign_up_model.dart';
import 'package:discussin_mobile/src/service/auth_service.dart';
import 'package:discussin_mobile/src/util/error_message.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpNotifier extends ChangeNotifier with FiniteState, ErrorMessage {
  final _authService = AuthService();

  Future<bool> register(SignUp signUp) async {
    setStateAction(StateAction.loading);
    try {
      await _authService.register(signUp);
      setErrorMessage(null);
      setStateAction(StateAction.none);
      return true;
    } on DioError catch (error) {
      setErrorMessage(error.response?.data['message']);
      setStateAction(StateAction.error);
      return false;
    }
  }
}

final signUpViewModel =
    ChangeNotifierProvider<SignUpNotifier>((ref) => SignUpNotifier());
