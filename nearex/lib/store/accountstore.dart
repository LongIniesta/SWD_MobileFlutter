import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountStoreScreen extends StatefulWidget {
  const AccountStoreScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return AccountStoreScreenState();
  }
}

class AccountStoreScreenState extends State<AccountStoreScreen> {
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
    return Center(
      child: Container(
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
                margin: EdgeInsets.only(top: 60),
                child: Text(
                  'Thông tin cửa hàng',
                  style: GoogleFonts.outfit(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 60, 125, 255)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.maxFinite,
                height: 730,
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
                            height: 300,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 74, 192, 243),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(File(pickFile!.path!)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 20),
                      child: Text(
                        'Tên cửa hàng',
                        style: GoogleFonts.outfit(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
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
                            hintText: 'Tên cửa hàng',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 20),
                      child: Text(
                        'Số điện thoại',
                        style: GoogleFonts.outfit(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
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
                            hintText: 'Số điện thoại',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 20),
                      child: Text(
                        'Địa chỉ',
                        style: GoogleFonts.outfit(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
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
                            hintText: 'Địa chỉ',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    alignment: Alignment.center,
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 117, 191, 252),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Đổi mật khẩu',
                      style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ),Align(
                alignment: Alignment.center,
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
                      'Cập nhật',
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
            )
          ],
        ),
      ),
    );
  }
}
