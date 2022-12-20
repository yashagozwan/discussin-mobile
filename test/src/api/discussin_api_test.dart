import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Discussin Api', () {
    late final DiscussinApi discussinApi;

    setUpAll(() {
      discussinApi = DiscussinApi();
    });
  });
}
