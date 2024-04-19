import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mir_book/database/db_helper.dart';
import 'package:mir_book/pages/detail_book_page.dart';
import 'package:mir_book/widgets/add_book.dart';
import 'package:mir_book/widgets/navbar_side.dart';

class ListBookPage extends StatefulWidget {
  const ListBookPage({super.key});

  @override
  State<ListBookPage> createState() => _ListBookPageState();
}

class _ListBookPageState extends State<ListBookPage> {
  late List<Map<String, dynamic>> _allData = [];

  String? selectedCategory;
  final TextEditingController judulBukuController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  // refresh data
  Future<void> _refreshData() async {
    final List<Map<String, dynamic>> data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
    });
  }

  // void _showModal([int? id]) async {
  //   if (id != null) {
  //     final existingData =
  //         _allData.firstWhere((element) => element['id'] == id);
  //     judulBukuController.text = existingData['title'];
  //     deskripsiController.text = existingData['description'];
  //     selectedCategory = existingData['category'] ;
  //   } else {
  //     judulBukuController.text = '';
  //     deskripsiController.text = '';
  //     selectedCategory = null;
  //   }

  //   final newData = await showCupertinoModalPopup(
  //     context: context,
  //     builder: (_) => Stack(
  //       children: [
  //         BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
  //           child: Container(
  //             color: Colors.transparent,
  //           ),
  //         ),
  //         Center(
  //           child: Container(
  //             margin: const EdgeInsets.only(top: 150),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(70),
  //             ),
  //             child: AddBookWidget(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("List MirBook"),
        ),
        drawer: NavbarSide(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            itemCount: _allData.length,
            itemBuilder: (context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailBook(
                        data: _allData[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ],
                      stops: [0.3, 0.7],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 15.0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/logo_mir_book.png',
                      ),
                    ),
                    title: Text(
                      _allData[index]['title'],
                      style: const TextStyle(
                        fontFamily: 'Nunito-Bold',
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      _allData[index]['description'],
                      maxLines: 2,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    // trailing: IconButton(
                    //   onPressed: () {
                    //     _showModal(_allData[index]['id']);
                    //   },
                    //   icon: const Icon(Icons.edit),
                    // ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
