import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearex/models/customer.dart';
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

  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneNumberController;
  TextEditingController? _addressController;
  TextEditingController? _genderController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () => {
                  // ???
                },
            icon: const Icon(Icons.arrow_back_rounded)),
        Text('Thông tin cá nhân', style: GoogleFonts.outfit()),
        Form(
            child: Column(
          children: [
            Image.asset('images/unknow.png'),
            Text('Họ và tên', style: GoogleFonts.openSans()),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  hintText: 'Nguyễn Văn A',
                  hintStyle: GoogleFonts.montserrat(fontSize: 14)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập họ và tên';
                }
                return null;
              },
            ),
            Text('Email', style: GoogleFonts.openSans()),
            TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: 'Nguyễn Văn A',
                    hintStyle: GoogleFonts.montserrat(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập họ và tên';
                  }
                  return null;
                }),
            Text('Số điện thoại', style: GoogleFonts.openSans()),
            TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                    hintText: 'Nguyễn Văn A',
                    hintStyle: GoogleFonts.montserrat(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập họ và tên';
                  }
                  return null;
                }),
            Text('Địa chỉ', style: GoogleFonts.openSans()),
            TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                    hintText: 'Nguyễn Văn A',
                    hintStyle: GoogleFonts.montserrat(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập họ và tên';
                  }
                  return null;
                }),
            Text('Ngày sinh', style: GoogleFonts.openSans()),
            ElevatedButton(
                onPressed: _onPressedDatePicker,
                child: Text(_selectedDate.toString(),
                    style: GoogleFonts.montserrat(fontSize: 14))),
            Text('Giới tính', style: GoogleFonts.openSans()),
            //drop down
            TextField(
              controller: _genderController,
              decoration: InputDecoration(
                  hintText: 'Nguyễn Văn A',
                  hintStyle: GoogleFonts.montserrat(fontSize: 14)),
            ),
          ],
        ))
      ],
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

  void initTextController() {
    fetchCustomerProfileData();
    _nameController = TextEditingController(text: customer?.userName);
    _emailController = TextEditingController(text: customer?.email);
    _phoneNumberController = TextEditingController(text: customer?.phone);
    _addressController = TextEditingController(text: customer?.address);
    _genderController = TextEditingController(text: customer?.gender);
  }
}
