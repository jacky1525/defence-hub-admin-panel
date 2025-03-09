import 'package:defence_hub_admin_panel/bloc/user/user_bloc.dart';
import 'package:defence_hub_admin_panel/constants.dart';
import 'package:defence_hub_admin_panel/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:defence_hub_admin_panel/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Users extends StatefulWidget {
  Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc,UserState>(
      builder: (context,state) {
        return Container(
          padding: EdgeInsets.all(Constants.defaultPadding),
          decoration: BoxDecoration(
            color: Constants.secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Users", style: Theme.of(context).textTheme.titleMedium),
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
                      child: dataTableWidget(state.userList),
                    ),
                  ),
                ),
              if (Responsive.isDesktop(context))
                SizedBox(width: double.infinity, child: dataTableWidget(state.userList)),
              if (Responsive.isTablet(context))
                SizedBox(width: double.infinity, child: dataTableWidget(state.userList)),
              // ✅ Eğer tablo taşarsa Scrollbar + SingleChildScrollView çalışacak
            ],
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
        .dispose(); // Bellek sızıntısını önlemek için dispose ettik
  }
}

Widget dataTableWidget(List<UserModel> user) {
  return DataTable(
    columnSpacing: Constants.defaultPadding,
    columns: [
      DataColumn(label: Text("UserName")),
      DataColumn(label: Text("Date")),
    ],
    rows: List.generate(
      user.length,
      (index) => userModelDataRow(user[index]),
    ),
  );
}

DataRow userModelDataRow(UserModel userModel) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Icon(FontAwesomeIcons.user),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.defaultPadding,
              ),
              child: Text(userModel.userName!),
            ),
          ],
        ),
      ),
      DataCell(Text(userModel.timeFormatted)),
    ],
  );
}
