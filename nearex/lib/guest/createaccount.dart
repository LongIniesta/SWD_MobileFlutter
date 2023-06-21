import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount(
      {super.key,
      required this.password,
      required this.phoneNumber,
      required this.googleUser});

  String? phoneNumber;
  String password;
  GoogleSignInAccount? googleUser;

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return CreateAccountState(phoneNumber, password, googleUser);
  }
}

class CreateAccountState extends State<CreateAccount> {
  PlatformFile? pickFile;
  TextEditingController txtPhoneController = TextEditingController();
  TextEditingController txtEmailController = TextEditingController();
  String linkImage = '';
  String? phoneNumber;
  GoogleSignInAccount? googleUser;
  String password;
  String error = '';
  String name = '';
  String gender = 'Nam';
  String address = '';
  String email = '';
  DateTime dob = DateTime.now();

  bool enableEmail = true;
  bool enabledPhone = true;

  CreateAccountState(this.phoneNumber, this.password, this.googleUser);

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: dob,
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        dob = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (phoneNumber != null) {
      enabledPhone = false;
      txtPhoneController.text = phoneNumber!;
    }
    if (googleUser != null) {
      enableEmail = false;
      email = googleUser!.email;
      txtEmailController.text = googleUser!.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child:
                    Image.asset('images/logo.png', alignment: Alignment.center),
              ),
              if (pickFile == null)
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async {
                      selectImage();
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/unknow.png'),
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
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(File(pickFile!.path!)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              Container(
                margin: EdgeInsets.only(left: 40, top: 10),
                child: const Text(
                  'Họ và tên',
                  style: TextStyle(
                      color: Color.fromARGB(255, 58, 58, 58),
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  //height: 60,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.only(left: 20),
                  width: 370,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 196, 196, 196),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintText: 'Họ và tên',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, top: 10),
                child: const Text(
                  'Ngày sinh',
                  style: TextStyle(
                      color: Color.fromARGB(255, 58, 58, 58),
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 370,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 196, 196, 196),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      _showDatePicker();
                      print(name + '-' + dob.toString());
                    },
                    child: TextField(
                      enabled: false,
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: '${dob.day}/${dob.month}/${dob.year}',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, top: 10),
                child: const Text(
                  'Giới tính',
                  style: TextStyle(
                      color: Color.fromARGB(255, 58, 58, 58),
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  //height: 60,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.only(left: 20),
                  width: 370,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 196, 196, 196),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton<String>(
                    underline: Container(
                      height: 0,
                    ),
                    value: gender,
                    style: TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        gender = newValue!;
                      });
                    },
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'Nam',
                        child: Text('Nam'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Nữ',
                        child: Text('Nữ'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'LGBT',
                        child: Text('LGBT'),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, top: 10),
                child: const Text(
                  'Địa chỉ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 58, 58, 58),
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  //height: 60,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.only(left: 20),
                  width: 370,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 196, 196, 196),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintText: 'Địa chỉ',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      address = value;
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, top: 10),
                child: const Text(
                  'Số điện thoại',
                  style: TextStyle(
                      color: Color.fromARGB(255, 58, 58, 58),
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  //height: 60,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.only(left: 20),
                  width: 370,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 196, 196, 196),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: txtPhoneController,
                    enabled: enabledPhone,
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintText: 'Số điện thoại',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, top: 10),
                child: const Text(
                  'Email',
                  style: TextStyle(
                      color: Color.fromARGB(255, 58, 58, 58),
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  //height: 60,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.only(left: 20),
                  width: 370,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 196, 196, 196),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: txtEmailController,
                    enabled: enableEmail,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  error,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 0, 0),
                    fontSize: 10,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      createAccount();
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        backgroundColor:
                            const Color.fromARGB(255, 75, 121, 227),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    child: const Text('Tiếp tục'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createAccount() async {
    setState(() {
      error = '';
      if (name == '') {
        error += 'Chưa nhập tên';
      }
      if (dob.isAfter(DateTime.now())) {
        if (error != '') error += ' | ';
        error += 'Ngày sinh không hợp lệ';
      }
      if (address == '') {
        if (error != '') error += ' | ';
        error += 'Chưa nhập địa chỉ';
      }
      if (phoneNumber == null || phoneNumber == '') {
        if (error != '') error += ' | ';
        error += 'Chưa nhập sđt';
      } else if (phoneNumber!.length != 10) {
        if (error != '') error += ' | ';
        error += 'Số điện thoại không hợp lệ';
      }

      if (email == '') {
        if (error != '') error += ' | ';
        error += 'Chưa nhập email';
      }
      if (email != '' && !email.contains('@')) {
        if (error != '') error += ' | ';
        error += 'Email không hợp lệ';
      }
    });
    if (error == '') {
      if (pickFile != null) {
        await uploadImage();
      }
      createAcc();
    }
  }

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickFile = result.files.first;
    });
  }
  

  Future uploadImage() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseAuth mAuth = FirebaseAuth.instance;
    
    if (mAuth.currentUser != null) {
      // do your stuff
    } else {
      mAuth.signInAnonymously();
    }
    final path = 'avts/${pickFile!.name}';
    final file = File(pickFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    linkImage = urlDownload;
  }

  Future<void> createAcc() async {
    var url = Uri.parse('https://swd-nearex.azurewebsites.net/api/user/create');
    String googleId = '';
    if (googleUser != null) {
      googleId = googleUser!.id;
    }
    print(googleId + "ok");
    String month = dob.month.toString();
    if (month.length == 1) month = '0' + month;
    String day = dob.day.toString();
    if (day.length == 1) day = '0' + day;
    String birthday = dob.year.toString() + '-' + month + '-' + day;
    Map<String, dynamic> body = {
      "email": "$email",
      "password": "$password",
      "userName": "$name",
      "phone": "$phoneNumber",
      "gender": "$gender",
      "dateOfBirth": "$birthday",
      "address": "$address",
      "avatar": "$linkImage",
      "googleId": "$googleId",
      "coordinateString": ""
    };
    print(body);

    try {
      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Request thành công, xử lý response
        print('Response body: ${response.body}');
      } else {
        // Request thất bại, xử lý lỗi
        print('Request failed with status code: ${response.body}');
      }
    } catch (e) {
      // Xử lý lỗi khi gửi request
      print('Error sending POST request: $e');
    }
  }
}
