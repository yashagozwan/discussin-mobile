import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart';

mixin FiniteStateComment on ChangeNotifier {
  StateAction stateActionComment = StateAction.none;

  void setStateActionComment(StateAction newAction) {
    stateActionComment = newAction;
    notifyListeners();
  }
}
