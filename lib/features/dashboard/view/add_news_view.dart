import 'package:defence_hub_admin_panel/constants.dart';
import 'package:defence_hub_admin_panel/widget/header.dart';
import 'package:flutter/material.dart';

class AddNewsView extends StatelessWidget {
  AddNewsView({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(Constants.defaultPadding),
        child: Column(
          children: [
            Header(isSearchVisible: false,),
            SizedBox(height: Constants.defaultPadding),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Haber Başlığı
                  Text(
                    "Haber Başlığı",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Haber başlığını girin...",
                    ),
                  ),
                  SizedBox(height: 16),

                  // Haber Görsel URL
                  Text(
                    "Haber Fotoğraf URL",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: imageUrlController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Görsel URL'ini girin...",
                    ),
                  ),
                  SizedBox(height: 16),

                  // Haber İçeriği
                  Text(
                    "Haber İçeriği",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: contentController,
                    maxLines: 6, // Çok satırlı destek
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Haber içeriğini buraya girin...",
                    ),
                  ),
                  SizedBox(height: 16),

                  // Haber Ekle Butonu
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Buraya haber ekleme işlemi backend'e bağlanınca eklenecek.
                        print("Haber Eklendi: ${titleController.text}");
                      },
                 
                      label: Text(
                        "HABERİ EKLE",
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.secondaryColor,
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
