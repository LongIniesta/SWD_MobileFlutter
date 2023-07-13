import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nearex/customer/customer_main.dart';
import 'package:nearex/utils/common_widget.dart';
import 'package:nearex/utils/data_storage.dart';

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomerLoginState();
  }
}

class _CustomerLoginState extends State<CustomerLogin> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String _error = "";
  @override
  Widget build(BuildContext context) {
    double height = DimensionValue.getScreenHeight(context);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height * 2 / 5,
          decoration: const BoxDecoration(
              gradient: ColorBackground.darkGradient,
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.elliptical(150, 30))),
          child: Image.asset('images/logo.png'),
        ),
        Form(
            child: Column(
          children: [
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(hintText: '0123456789'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Xin hãy nhập số điện thoại của bạn';
                }
                if (value.length != 10) {
                  return 'Số điện thoại có 10 chữ số';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              obscuringCharacter: '*',
              decoration: const InputDecoration(hintText: 'Mật khẩu'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Xin hãy nhập mật khẩu của bạn';
                }
                return null;
              },
            ),
            Text(
              _error,
              style: const TextStyle(color: Colors.red),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (await login(
                      _passwordController.text, _phoneController.text)) {
                    navigate();
                  }
                },
                child: const Text('Login'))
          ],
        )),
        ElevatedButton(
            onPressed: () async {
              if (await loginWithGoogle()) {
                navigate();
              }
            },
            child: const Text('Login with Google'))
      ],
    ));
  }

  Future<bool> login(String password, String phone) async {
    Uri uri = Uri.parse('https://swd-nearex.azurewebsites.net/api/user/login');
    Map<String, dynamic> body = {"phone": phone, "password": password};
    Response response = await post(uri, body: body);
    if (response.statusCode == 200) {
      saveCustomerState(response.body);
      return true;
    } else {
      setState(() {
        _error = 'Số điện thoại hoặc mật khẩu không chính xác';
      });
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    Uri uri =
        Uri.parse('https://swd-nearex.azurewebsites.net/api/user/login-google');
    //Map<String, dynamic> body = {"googleId": };
    Response response = await post(uri);
    if (response.statusCode == 200) {
      saveCustomerState(response.body);
      return true;
    } else {
      return false;
    }
  }

  void saveCustomerState(String customerJson) {
    DataStorage.secureStorage.write(key: "customer", value: customerJson);
  }

  void navigate() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainCustomer()));
  }
}
