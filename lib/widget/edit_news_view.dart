import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class EditNewsView extends StatefulWidget {
  final String documentId; // Düzenlenecek haberin Firestore ID'si

  const EditNewsView({super.key, required this.documentId});

  @override
  _EditNewsViewState createState() => _EditNewsViewState();
}

class _EditNewsViewState extends State<EditNewsView> {
  final TextEditingController titleController = TextEditingController();
  /*   final TextEditingController contentController = TextEditingController();
 */
  final TextEditingController imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNewsData();
  }

  Future<void> _loadNewsData() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance
            .collection('news')
            .doc(widget.documentId)
            .get();

    if (doc.exists) {
      setState(() {
        titleController.text = doc['title'];
        /*         contentController.text = doc['content'] ?? ""; // İçerik opsiyonel olabilir
 */
        imageUrlController.text = doc['imageUrl'];
      });
    }
  }

  Future<void> _updateNews() async {
    await FirebaseFirestore.instance
        .collection('news')
        .doc(widget.documentId)
        .update({
          'title': titleController.text,
          /*       'content': contentController.text,
 */
          'imageUrl': imageUrlController.text,
        });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Haber başarıyla güncellendi!")));

    context.go("/main");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Haber Düzenle"),
  leading: IconButton(
    icon: Icon(Icons.arrow_back), // 🔙 Geri butonu
    onPressed: () {
      if (GoRouter.of(context).canPop()) {
        context.pop(); // Eğer geri gidilebilecek bir sayfa varsa git
      } else {
        context.go("/main"); // Geri gidilecek bir sayfa yoksa ana sayfaya yönlendir
      }
    },
  ),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Başlık"),
            ),
            SizedBox(height: 10),
            /*  TextField(
              controller: contentController,
              maxLines: 5,
              decoration: InputDecoration(labelText: "İçerik"),
            ),
            SizedBox(height: 10), */
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: "Görsel URL"),
            ),
            SizedBox(height: 10),
            imageUrlController.text.isNotEmpty
                ? Image.network(
                  "https://mediacdn.yirmidort.tv/Documents/yirmidorthaber/images/2025/01/07/savunma-sanayii-sirketler-197.jpg",
                  width: 250,
                  height: 150,
                  fit: BoxFit.cover,
                )
                : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateNews,
              child: Text("Güncelle", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
