import 'package:defence_hub_admin_panel/bloc/news/news_bloc_exports.dart';
import 'package:defence_hub_admin_panel/constants.dart';
import 'package:defence_hub_admin_panel/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:defence_hub_admin_panel/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LastNews extends StatefulWidget {
  LastNews({super.key});

  @override
  State<LastNews> createState() => _LastNewsState();
}

class _LastNewsState extends State<LastNews> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(Constants.defaultPadding),
          decoration: BoxDecoration(
            color: Constants.secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Last News", style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: Constants.defaultPadding),

              if (Responsive.isMobile(context))
                Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true, // Kaydırma çubuğunu her zaman göster
                  thickness: 8, // Çubuk kalınlığı
                  radius: Radius.circular(10), // Yuvarlak köşeler
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth:
                            MediaQuery.of(
                              context,
                            ).size.width, // Taşarsa kaydırmayı zorunlu yap
                      ),
                      child: dataTableWidget(state.newsList,context),
                    ),
                  ),
                ),
              if (Responsive.isDesktop(context))
                SizedBox(width: double.infinity, child: dataTableWidget(state.newsList,context)),
              if (Responsive.isTablet(context))
                SizedBox(width: double.infinity, child: dataTableWidget(state.newsList,context)),
              // ✅ Eğer tablo taşarsa Scrollbar + SingleChildScrollView çalışacak
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
        .dispose(); // Bellek sızıntısını önlemek için dispose ettik
  }
}

Widget dataTableWidget(List<NewsModel> news,BuildContext context) {
  return DataTable(
    columnSpacing: Constants.defaultPadding,
    columns: [
      DataColumn(label: Text("News Name")),
      DataColumn(label: Text("Document ID")),
      DataColumn(label: Text("Date")),
      DataColumn(label: Text("Actions")),
    ],
    rows: List.generate(
      news.length,
      (index) => lastNewsDataRow(news[index],context),
    ),
  );
}

DataRow lastNewsDataRow(NewsModel newModel,BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Text(newModel.title,style: TextStyle(fontSize: 12),),
      ),
      DataCell(Text(newModel.documentId,style: TextStyle(fontSize: 12),)),
      DataCell(Text(newModel.timeFormatted,style: TextStyle(fontSize: 12),)),
      DataCell(
        Row(
          children: [
            // Düzenleme Butonu
            IconButton(
              icon: Icon(Icons.edit,size: 16,),
              onPressed: () {
                String docId = newModel.documentId;
                context.go("/news-edit/$docId");
                // TODO: Buraya düzenleme ekranına gitme kodunu ekle
              },
            ),

            // Silme Butonu
            IconButton(icon: Icon(Icons.delete,size: 16,), onPressed: () {}),
          ],
        ),
      ),
    ],
  );
}
