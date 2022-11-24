import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Profile {
  String username;
  String subname;
  int followers;
  int following;

  Profile (
    this.username,
    this.subname,
    this.followers,
    this.following
  );
}