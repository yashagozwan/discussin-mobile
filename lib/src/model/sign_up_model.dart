class SignUp {
  String username;
  String email;
  String password;
  bool isAdmin;

  SignUp({
    required this.username,
    required this.email,
    required this.password,
    this.isAdmin = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'isAdmin': isAdmin,
    };
  }
}
