import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends ChangeNotifier {
  int _selectedIndexScreen = 0;

  int get selectedIndexScreen => _selectedIndexScreen;

  void setSelectedIndexScreen(int index) {
    _selectedIndexScreen = index;
    notifyListeners();
  }
}

final homeViewModel = ChangeNotifierProvider<HomeViewModel>(
  (ref) {
    return HomeViewModel();
  },
);
