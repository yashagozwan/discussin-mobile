import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserResponse {
  String message;
  User data;

  UserResponse({required this.message, required this.data,});

  factory UserResponse.fromMap(Map<String, dynamic> data) {
    

    return UserResponse(
      message: data['message'],
      data: User.fromJson(data['data']),
    );
  }
}

class User {
  int id;
  String username;
  String email;
  String photo;
  bool isAdmin;
  int banUntil;

  User({
      required this.id, 
      required this.username, 
      required this.email, 
      required this.photo, 
      required this.isAdmin, 
      required this.banUntil, 
  });

  factory User.fromJson(Map<String, dynamic> data) {
  
    return User(id: data["id"], username: data["username"], email: data["email"], photo: data["photo"], isAdmin: data["isAdmin"], banUntil: data["banUntil"],);
  
  }
  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, photo: $photo, isAdmin: $isAdmin, banUntil: $banUntil)';
    
  }
}