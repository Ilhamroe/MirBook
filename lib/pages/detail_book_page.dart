import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mir_book/database/db_helper.dart';
import 'package:mir_book/pages/b_home_page.dart';
import 'package:mir_book/widgets/edit_book.dart';
import 'package:mir_book/widgets/navbar_side.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DetailBook extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailBook({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailBook> createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  String? selectedCategory;
  bool isLoading = false;
  int? id;

  final TextEditingController judulBukuController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  late List<Map<String, dynamic>> allData = [];
  late String titleBook;
  late String descBook;
  late String categoryBook;
  PlatformFile? attachedFile;

  // refresh data
  Future<void> _refreshData() async {
    final List<Map<String, dynamic>> data = await SQLHelper.getAllData();
    setState(() {
      allData = data;
    });
  }

  //Delete Data
  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BeforeHomePage(),
      ),
    );
    _refreshData();
  }

  void _showModal([int? id]) async {
    if (id != null) {
      final existingData = allData.firstWhere((element) => element['id'] == id);
      judulBukuController.text = existingData['title'];
      deskripsiController.text = existingData['description'];
      selectedCategory = existingData['category'];
      setState(() {
        titleBook = existingData['title'];
        descBook = existingData['description'];
        categoryBook = existingData['category'];
      });
    } else {
      judulBukuController.text = '';
      deskripsiController.text = '';
      selectedCategory = null;
    }

    final newData = await showCupertinoModalPopup(
      context: context,
      builder: (_) => Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
              ),
              child: EditBookWidget(
                idBook: widget.data['id'],
                exisiting_data: {
                  "id" : widget.data['id'],
                  "title": judulBukuController.text,
                  "description": deskripsiController.text,
                  "category": selectedCategory
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getSingleData(int id) async {
    final data = await SQLHelper.getSingleData(id);
    setState(() {
      judulBukuController.text = data[0]['title'];
      deskripsiController.text = data[0]['description'];
      selectedCategory = data[0]['category'];
      titleBook = data[0]['title'];
      descBook = data[0]['description'];
      categoryBook = data[0]['category'];
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
    id = widget.data['id'];
    titleBook = widget.data['title'];
    descBook = widget.data['description'];
    categoryBook = widget.data['category'];
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
            "View MirBook",
            style: TextStyle(fontFamily: 'Nunito-Bold'),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _showModal(widget.data['id']),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteData(widget.data['id']);
              },
            ),
          ],
        ),
        drawer: const NavbarSide(),
        body: ListView(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo_mir_book.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 7),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo_mir_book.png',
                    width: 120,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  titleBook,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: Text(
                        "Description",
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'Nunito-Bold'),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: Text(
                        descBook,
                        style:
                            const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: Text(
                        "Category",
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'Nunito-Bold'),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: Text(
                        categoryBook,
                        style:
                            const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf', 'doc', 'docx'],
                    );
                    if (result == null || result.files.isEmpty) return;

                    setState(() {
                      attachedFile = result.files.first;
                    });

                    await saveFilePermanently(attachedFile!);

                    await _refreshData();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 45.0),
                  ),
                  icon: const Icon(Icons.attach_file),
                  label: const Text(
                    'Attach File',
                    style: TextStyle(fontSize: 18.0, fontFamily: 'Nunito-Bold'),
                  ),
                ),
                if (attachedFile != null)
                  InkWell(
                    onTap: () => OpenFile.open(attachedFile!.path),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            'Attached File:',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          child: Text(attachedFile!.name),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    await File(file.path!).copy(newFile.path);
    await _refreshData();
  }
}
