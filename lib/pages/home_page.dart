import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mir_book/database/db_helper.dart';
import 'package:mir_book/widgets/navbar_side.dart';
import 'package:mir_book/widgets/view_book.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> allData = [];

  // refresh data
  Future<void> _refreshData() async {
    final List<Map<String, dynamic>> data = await SQLHelper.getAllData();
    setState(() {
      allData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Widget _buildCustomButton(
      String label, IconData icon, Color color, VoidCallback onPressed) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: color,
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 8.0),
              Text(label,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18.0,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
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
          title: const Text(
            "Beranda MirBook",
            style: TextStyle(fontFamily: 'Nunito-Bold'),
          ),
        ),
        drawer: NavbarSide(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
                child: Text(
                  'Book',
                  style: TextStyle(fontFamily: 'Nunito-Bold', fontSize: 24.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCustomButton(
                        'All Category', Icons.category, Colors.blue, () {}),
                    _buildCustomButton('Teknologi',
                        Icons.browser_updated_rounded, Colors.green, () {}),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCustomButton('Kesehatan',
                        Icons.local_hospital_rounded, Colors.orange, () {}),
                    _buildCustomButton(
                        'Sejarah', Icons.history, Colors.red, () {}),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCustomButton('Ensiklopedia',
                        Icons.library_books_outlined, Colors.brown, () {}),
                    _buildCustomButton(
                        'Bisnis', Icons.business, Colors.indigo, () {}),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                child: const ViewBookWidget(),
              )
              // ViewBookWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
