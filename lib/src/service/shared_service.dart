import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class SharedService {
  static final _shared = SharedPreferences.getInstance();
  static const _token = 'token';

  Future<bool> saveToken(String token) async {
    final shared = await _shared;
    return await shared.setString(_token, token);
  }

  Future<String?> getToken() async {
    final shared = await _shared;
    return shared.getString(_token);
  }

  Future<bool> removeToken() async {
    final token = await getToken();
    if (token == null) return false;

    final shared = await _shared;
    return await shared.remove(_token);
  }
}
