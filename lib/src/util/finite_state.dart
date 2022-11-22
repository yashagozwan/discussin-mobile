import 'package:flutter/material.dart';

enum StateAction {
  none,
  loading,
  error,
}

mixin FiniteState on ChangeNotifier {
  StateAction actionState = StateAction.none;

  void setActionState(StateAction newState) {
    actionState = newState;
    notifyListeners();
  }
}
