import 'package:discussin_mobile/src/util/time_format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Time Format', () {
    final createdAt = DateTime.now().millisecondsSinceEpoch;
    final result = timeFormat(createdAt);
    print(result);
  });
}
