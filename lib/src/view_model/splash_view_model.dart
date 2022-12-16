import 'package:discussin_mobile/src/service/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashNotifier extends ChangeNotifier {
  final _sharedService = SharedService();

  Future<String?> getToken() async {
    return await _sharedService.getToken();
  }
}

final splashViewModel =
    ChangeNotifierProvider<SplashNotifier>((ref) => SplashNotifier());
