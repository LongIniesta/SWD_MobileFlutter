import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  String category = 'Mì gói';
  PlatformFile? pickFile;
  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color.fromRGBO(233, 248, 249, 1),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 50, left: 10),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(95, 206, 206, 206)),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 65),
                  child: Text(
                    'Thêm sản phẩm mới',
                    style: GoogleFonts.outfit(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 15, 14, 36)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.maxFinite,
                  height: 650,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (pickFile == null)
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                selectImage();
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                width: double.maxFinite,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage('images/uploadimg.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                selectImage();
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                width: double.maxFinite,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: FileImage(File(pickFile!.path!)),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            'Tên sản phẩm',
                            style: GoogleFonts.outfit(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                hintText: 'Tên sản phẩm',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            'Phân loại sản phẩm',
                            style: GoogleFonts.outfit(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: DropdownButton<String>(
                              underline: Container(
                                height: 0,
                              ),
                              value: category,
                              style: TextStyle(color: Colors.black),
                              onChanged: (String? newValue) {
                                setState(() {
                                  category = newValue!;
                                });
                              },
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'Mì gói',
                                  child: Text('Mì gói'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Trái cây',
                                  child: Text('Trái cây'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Nước ngọt',
                                  child: Text('Nước ngọt'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            'Mô tả',
                            style: GoogleFonts.outfit(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                hintText: 'Mô tả',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            'Nơi sản xuất',
                            style: GoogleFonts.outfit(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                hintText: 'Nơi sản xuất',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            'Đơn vị tính',
                            style: GoogleFonts.outfit(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                hintText: 'Đơn vị tính',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            'Giá gốc',
                            style: GoogleFonts.outfit(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                hintText: '0',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 117, 191, 252),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Thêm',
                      style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
