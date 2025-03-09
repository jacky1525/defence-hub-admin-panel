import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserModel {
  final String age;
  final String city;
  final String gender;
  final String mail;
  final String name;
  final String password;
  final String surname;
  final DateTime time;
  final String userName;

  UserModel({
    required this.time,
    required this.userName,
    required this.name,
    required this.surname,
    required this.age,
    required this.city,
    required this.gender,
    required this.mail,
    required this.password,
  });

  String get timeFormatted {
    return DateFormat('dd-MM-yyyy').format(time);
  }

   factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return UserModel(
      userName: data['userName'], 
      name: data['name'], 
      surname: data['surname'], 
      age: data['age'],
      city: data['city'], 
      gender: data['gender'], 
      mail: data['mail'], 
      password: data['password'],  // Parola şifresi şifrelemek için hash alınmalı
      time: (data['time'] as Timestamp).toDate(), 
      // Timestamp'ı DateTime'a dönüştürme
    );
  }
}
