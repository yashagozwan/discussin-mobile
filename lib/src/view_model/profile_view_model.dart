import 'package:discussin_mobile/src/service/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends ChangeNotifier {
  final _sharedService = SharedService();
  Future<bool> removeToken() async {
    return await _sharedService.removeToken();
  }
}

final profileViewModel =
    ChangeNotifierProvider<ProfileNotifier>((ref) => ProfileNotifier());
