import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nearex/customer/customer_main.dart';
import 'package:nearex/model/customer.dart';
import 'package:nearex/services/customer_service.dart';

import '../utils/data_storage.dart';

class PasswordToLogin extends StatefulWidget {
  PasswordToLogin({super.key, required this.phone});
  String phone;

  @override
  State<StatefulWidget> createState() {
    return PasswordLoginState(phone);
  }
}

class PasswordLoginState extends State<PasswordToLogin> {
  String phone = '';
  var obscureText2 = true;
  var pass = '';
  String phoneHint = '';
  var error = '';
  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= phone.length; i++) {
      phoneHint += '*';
    }
    phoneHint += phone.substring(phone.length - 3, phone.length);
  }

  PasswordLoginState(this.phone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(color: Colors.white),
          width: double.maxFinite,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Nhập mật khẩu',
              style: TextStyle(
                  color: Color.fromRGBO(24, 24, 35, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            Text(
              'Nhập mật khẩu cho sđt $phoneHint',
              style: const TextStyle(
                  color: Color.fromRGBO(90, 90, 90, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 5),
              child: Text('Mật khẩu'),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black12),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              height: 40,
              width: 400,
              child: TextFormField(
                obscureText: obscureText2,
                //textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText2 = !obscureText2;
                      });
                    },
                    child: obscureText2
                        ? const Icon(
                            Icons.visibility_off,
                            color: Color.fromARGB(255, 203, 230, 244),
                          )
                        : const Icon(
                            Icons.visibility,
                            color: Color.fromARGB(255, 203, 230, 244),
                          ),
                  ),
                  hintText: 'Nhập mật khẩu',
                  hintStyle: const TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 179, 179, 179)),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  pass = value;
                },
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 78, 78, 78)),
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              // height: 40,
              // width: ,
              child: SizedBox(
                height: 40,
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: const Color.fromARGB(255, 75, 121, 227),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  child: const Text('Tiếp tục'),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void saveCustomerState(String customerJson, Customer customer) {
    CustomerService.customer = customer as Customer?;
    DataStorage.secureStorage.write(key: "customer", value: customerJson);
  }

  Future<void> login() async {
    setState(() {
      if (pass == '') {
        error = 'Vui lòng nhập mật khẩu';
      } else {
        error = '';
      }
    });
    if (error == '') {
      var url = Uri.parse(
          'https://swd-nearex.azurewebsites.net/api/users/authentication');
      Map<String, dynamic> body = {"phone": phone, "password": pass};

      try {
        http.Response response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          print(response.body.toString());
          Map<String, dynamic> jsonData = json.decode(response.body.toString());
          Customer customer = Customer(
              address: jsonData['address'],
              avatar: jsonData['avatar'],
              coordinateString: jsonData['coordinateString'],
              dateOfBirth: DateTime.parse(jsonData['dateOfBirth']),
              email: jsonData['email'],
              fcmtoken: jsonData['fcmtoken'],
              gender: jsonData['gender'],
              googleId: jsonData['googleId'],
              id: jsonData['id'],
              passwordHash: jsonData['passwordHash'],
              passwordSalt: jsonData['passwordSalt'],
              phone: jsonData['phone'],
              token: jsonData['token'],
              userName: jsonData['userName'],
              verificationToken: jsonData['verificationToken'],
              verifiedAt: jsonData['verifiedAt'],
              wishList: null);
          saveCustomerState(response.body, customer);
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainCustomer(
                        customer: customer,
                      )));
        } else {
          // Request thất bại, xử lý lỗi
          print(
              'Request failed with status code: ${response.statusCode.toString()}');
        }
      } catch (e) {
        // Xử lý lỗi khi gửi request
        print('Error sending POST request: $e');
      }
    }
  }
}
