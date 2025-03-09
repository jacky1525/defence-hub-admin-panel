import 'package:defence_hub_admin_panel/models/news_model.dart';
import 'package:defence_hub_admin_panel/models/user_model.dart';
import 'package:defence_hub_admin_panel/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository extends FirebaseAuthService {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepository(this._firebaseAuthService);


  Future<void> addNewsToFirestore(
      {required String title, required String imageUrl}) async {
    return await _firebaseAuthService.addNews(
      title: title,
      imageUrl: imageUrl,
    );
  }



  Stream<List<NewsModel>> getNewsFromFirestore()  {
    return  _firebaseAuthService.getNews();
  }

  Stream<List<UserModel>> getUsersFromFirestore() {
    return _firebaseAuthService.getUsers();
  }



  Future<String?> userLogin({
    required String userName,
    required String password,
  }) async {
    return await _firebaseAuthService.loginUser(password: password, userName: userName);
  }

  
}
