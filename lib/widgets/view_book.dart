import 'package:flutter/material.dart';
import 'package:mir_book/database/db_helper.dart';
import 'package:mir_book/pages/detail_book_page.dart';

class ViewBookWidget extends StatefulWidget {
  const ViewBookWidget({super.key});

  @override
  State<ViewBookWidget> createState() => _ViewBookWidgetState();
}

class _ViewBookWidgetState extends State<ViewBookWidget> {
  late List<Map<String, dynamic>> _allData = [];

  // refresh data
  Future<void> _refreshData() async {
    final List<Map<String, dynamic>> data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _allData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _refreshData();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailBook(
                    data: _allData[index],
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AspectRatio(
                aspectRatio: 12 / 16,
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          _allData[index]['title'],
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Nunito-Bold'),
                        ),
                        Image.asset('assets/images/logo_mir_book.png'),
                        const SizedBox(width: 16.0),
                        Column(
                          children: [
                            Text(
                              _allData[index]['description'],
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 20, fontFamily: 'Nunito'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
