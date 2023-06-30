import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearex/models/customer.dart';
import 'package:nearex/utils/common_widget.dart';
import 'package:nearex/utils/data_storage.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomerProfileState();
  }
}

class _CustomerProfileState extends State<CustomerProfile> {
  Customer? customer;
  double _screenWidth = 0;
  double _screenHeight = 0;
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneNumberController;
  TextEditingController? _addressController;
  TextEditingController? _genderController;

  @override
  Widget build(BuildContext context) {
    _screenWidth = DimensionValue.getScreenWidth(context);
    _screenHeight = DimensionValue.getScreenHeight(context);
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
                  Image.asset('images/unknow.png'),
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
                  //drop down
                  TextField(
                    controller: _genderController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Nguyễn Văn A',
                        hintStyle: GoogleFonts.montserrat(fontSize: 14)),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void fetchCustomerProfileData() async {
    final customerJson = await DataStorage.storage.read(key: 'customer');
    if (customerJson != null) {
      setState(() {
        customer = Customer.fromJson(jsonDecode(customerJson));
      });
    }
  }

  DateTime? _selectedDate = DateTime.now();
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

  void initTextController() {
    fetchCustomerProfileData();
    _nameController = TextEditingController(text: customer?.userName);
    _emailController = TextEditingController(text: customer?.email);
    _phoneNumberController = TextEditingController(text: customer?.phone);
    _addressController = TextEditingController(text: customer?.address);
    _genderController = TextEditingController(text: customer?.gender);
  }
}
