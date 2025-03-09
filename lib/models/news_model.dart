import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NewsModel {
  final String documentId;
  final String title;
  final String imageUrl;
  final DateTime time;

  NewsModel({
    required this.documentId,
    required this.title,
    required this.imageUrl,
    required this.time,
  });

  String get timeFormatted {
    return DateFormat('dd-MM-yyyy').format(time);
  }

  factory NewsModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return NewsModel(
      documentId: doc.id,
      imageUrl: data['imageUrl'] ?? '',
      title: data['title'] ?? '',
      time:
          (data['time'] as Timestamp)
              .toDate(), // Timestamp'ı DateTime'a dönüştürme
    );
  }
}
