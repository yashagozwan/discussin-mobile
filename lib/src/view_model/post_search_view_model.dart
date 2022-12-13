import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../util/finite_state.dart';

mixin FiniteStateSearch on ChangeNotifier {
  StateAction stateActionSearch = StateAction.none;

  void setStateActionSearch(StateAction newAction) {
    stateActionSearch = newAction;
    notifyListeners();
  }
}

class CardTitleData {
  String headTitle;
  String bodyTitle;
  String subTitle;

  CardTitleData(
    this.headTitle,
    this.bodyTitle,
    this.subTitle,
  );
}

class PostSearchNotifier extends ChangeNotifier with FiniteState {
  String get inputSearch => _inputSearch;
  String _inputSearch = "";

  void setInputSearch(String newInput) {
    _inputSearch = newInput;
    notifyListeners();
  }

  static Iterable<CardTitleData> getTrends() {
    return [
      CardTitleData(
        'Trending in News Topics',
        'G20 In Indonesia',
        '2.683 Discuss',
      ),
      CardTitleData(
        'Trending in Tech Topics',
        'Artificial Intelligent',
        '2.683 Discuss',
      ),
      CardTitleData(
        'Trending in Sport Topics',
        'Word Cup 2022',
        '2.683 Discuss',
      ),
      CardTitleData(
        'Trending in Travel Topics',
        'Bali',
        '2.683 Discuss',
      ),
      CardTitleData(
        'Trending in Kpop Topics',
        'Jisoo BLACKPINK',
        '2.683 Discuss',
      ),
      CardTitleData(
        'Trending in Anime Topics',
        'Tensei Shitara Slime Datta Ken',
        '2.683 Discuss',
      )
    ];
  }
}

final postSearchViewModel = ChangeNotifierProvider<PostSearchNotifier>(
  (ref) {
    return PostSearchNotifier();
  },
);
