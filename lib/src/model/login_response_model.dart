class LoginResponse {
  String message;
  _Data data;

  LoginResponse({
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromMap(
    Map<String, dynamic> data,
  ) {
    return LoginResponse(
      message: data['message'],
      data: _Data.fromMap(data['data']),
    );
  }

  @override
  String toString() {
    return 'LoginResponse(message: $message, data: $data)';
  }
}

class _Data {
  int id;
  String username;
  String token;

  _Data({
    required this.id,
    required this.username,
    required this.token,
  });

  factory _Data.fromMap(Map<String, dynamic> data) {
    return _Data(
      id: data['id'],
      username: data['username'],
      token: data['token'],
    );
  }

  @override
  String toString() {
    return 'Data(id: $id, username: $username, token: $token)';
  }
}
