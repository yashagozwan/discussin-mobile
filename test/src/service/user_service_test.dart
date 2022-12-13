import 'package:discussin_mobile/src/service/user_service.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  group("User Service ", () {
    late UserService userService;

    setUpAll(() {
      userService = UserService();
    });

    test("Get User", () async {
      final result = await userService.getUser();
    });

    test("Update User", () async {
      try {
        final userUpdate = UserUpdate(
          username: "qwerty",
          photo:
              "https://assets.pikiran-rakyat.com/crop/0x0:0x0/x/photo/2021/01/18/2768797339.jpeg",
        );
        final result = await userService.updateUser(userUpdate);
      } catch (e) {}
    });
  });
}
