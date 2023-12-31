import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearex/services/customer_service.dart';
import 'package:nearex/services/firebase_service.dart';
import 'package:nearex/utils/common_widget.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomerProfileState();
  }
}

class _CustomerProfileState extends State<CustomerProfile> {
  var customer = CustomerService.customer;
  double _screenWidth = 0;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  late String _selectedGender;
  late DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: customer?.userName);
    _emailController = TextEditingController(text: customer?.email);
    _phoneNumberController = TextEditingController(text: customer?.phone);
    _addressController = TextEditingController(text: customer?.address);
    String? gender = customer?.gender;
    if (gender != null) {
      if (gender == 'Female' || gender == 'Nữ') {
        _selectedGender = 'Nữ';
      } else if (gender == 'Male' || gender == 'Nam') {
        _selectedGender = 'Nam';
      } else {
        _selectedGender = 'Không rõ';
      }
    } else {
      _selectedGender = 'Không rõ';
    }
    if (customer?.dateOfBirth != null) {
      _selectedDate = customer?.dateOfBirth as DateTime;
    } else {
      _selectedDate = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = DimensionValue.getScreenWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin cá nhân', style: GoogleFonts.outfit()),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(_screenWidth / 24),
          child: Column(
            children: [
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: _updateAvatar,
                    child: Image.asset(
                      'images/unknow.png',
                      scale: 1,
                    ),
                  ),
                  Text('Họ và tên',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: _screenWidth / 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Nguyễn Văn A',
                        hintStyle: GoogleFonts.montserrat(fontSize: 14)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập họ và tên';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: _screenWidth / 20),
                  Text('Email',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: _screenWidth / 20),
                  TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Nguyễn Văn A',
                          hintStyle: GoogleFonts.montserrat(fontSize: 14)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập họ và tên';
                        }
                        return null;
                      }),
                  SizedBox(height: _screenWidth / 20),
                  Text('Số điện thoại',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: _screenWidth / 20),
                  TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Nguyễn Văn A',
                          hintStyle: GoogleFonts.montserrat(fontSize: 14)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập họ và tên';
                        }
                        return null;
                      }),
                  SizedBox(height: _screenWidth / 20),
                  Text('Địa chỉ',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: _screenWidth / 20),
                  TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Nguyễn Văn A',
                          hintStyle: GoogleFonts.montserrat(fontSize: 14)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập họ và tên';
                        }
                        return null;
                      }),
                  SizedBox(height: _screenWidth / 20),
                  Text('Ngày sinh',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: _screenWidth / 20),
                  ElevatedButton(
                      onPressed: _onPressedDatePicker,
                      child: Text(_selectedDate.toString(),
                          style: GoogleFonts.montserrat(fontSize: 14))),
                  SizedBox(height: _screenWidth / 20),
                  Text('Giới tính',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: _screenWidth / 20),
                  DropdownButton(
                    items: [
                      DropdownMenuItem(
                        child: Text('Nam'),
                        value: 'Nam',
                      ),
                      DropdownMenuItem(
                        child: Text('Nữ'),
                        value: 'Nữ',
                      ),
                      DropdownMenuItem(
                        child: Text('Không rõ'),
                        value: 'Không rõ',
                      )
                    ],
                    onChanged: (value) {},
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Cập nhật')),
                  ElevatedButton(onPressed: () {}, child: Text('Đổi mật khẩu'))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedDatePicker() async {
    DateTime? pickedDateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDateTime != null && pickedDateTime != _selectedDate) {
      setState(() {
        _selectedDate = pickedDateTime;
      });
    }
  }

  void _updateAvatar() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) {
      return;
    }
    PlatformFile platformFile = result.files.first;
    File file = File(platformFile.path!);
    // String fileName = 'avatar-$customerId';
    var filePath = await FirebaseStorageService.uploadFile(
        file: file,
        fileName: 'avatar-9',
        fileDirectory: FirebaseStorageService.imageDirectory);
    CustomerService.updateCustomer(
        customerId: CustomerService.customer!.id as int, avatar: filePath);
  }

  void _update() {
    CustomerService.updateCustomer(
        customerId: customer!.id as int,
        email: _emailController.text != customer!.email
            ? _emailController.text
            : null,
        userName: _nameController.text != customer!.userName
            ? _nameController.text
            : null,
        phone: _phoneNumberController.text != customer!.phone
            ? _phoneNumberController.text
            : null,
        address: _addressController.text != customer!.address
            ? _addressController.text
            : null);
  }
}
