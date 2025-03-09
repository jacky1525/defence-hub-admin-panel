import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:defence_hub_admin_panel/models/news_model.dart';
import 'package:defence_hub_admin_panel/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // add news to firestore
  Future<void> addNews({
    required String title,
    required String imageUrl,
  }) async {
    try {
      await _firestore.collection("news").add({
        "title": title,
        "imageUrl": imageUrl,
        "time": Timestamp.now(),
      });
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return;
    }
    return;
  }

  // get news from firestore

  Stream<List<NewsModel>> getNews() {
    CollectionReference newsCollection = _firestore.collection('news');

    return newsCollection.orderBy('time', descending: true).snapshots().map((
      querySnapshot,
    ) {
      return querySnapshot.docs.map((doc) {
        return NewsModel.fromFirestore(doc);
      }).toList();
    });
  }



    Stream<List<UserModel>> getUsers() {
    CollectionReference usersCollection = _firestore.collection('users');

    return usersCollection.orderBy('time', descending: true).snapshots().map((
      querySnapshot,
    ) {
      return querySnapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc);
      }).toList();
    });
  }

  loginUser({required String password, required String userName}) {
    try {
      int userLogin;

      if (userName == "jacky15" || password == "Benvesen123.") {
        userLogin = 1;
      } else {
        userLogin = 0;
      }
      return userLogin;
    } catch (e) {
      debugPrint("Bad login");
    }
  }

  getSelectedNews({required String docId}) async{
     DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('news')
        .doc(docId)
        .get();

        
  }

}
