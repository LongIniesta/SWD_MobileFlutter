import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, // Điểm bắt đầu gradient
            end: Alignment.bottomRight, // Điểm kết thúc gradient
            colors: [
              Color.fromARGB(255, 11, 0, 61),
              Color.fromARGB(255, 49, 49, 49),
            ],
          ),
        ),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.center,
              child:
                  Image.asset('images/logo.png', alignment: Alignment.center),
            ),
            Container(
                height: 600,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/backwhitemain.png'),
                      fit: BoxFit.fill),
                ),
                //alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Welcome To NearEx',
                      style: TextStyle(
                          color: Color.fromARGB(255, 8, 6, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Nhập số điện thoại để tiếp tục',
                      style: TextStyle(
                          color: Color.fromARGB(255, 58, 58, 58),
                          fontWeight: FontWeight.w400,
                          fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      //height: 60,
                      width: 370,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 196, 196, 196),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: InternationalPhoneNumberInput(
                        keyboardType: TextInputType.phone,
                        onInputChanged: (value) {},
                        cursorColor: Colors.black,
                        inputDecoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'So dien thoai cua ban',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 40,
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          // Xử lý sự kiện khi nút được nhấn
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            backgroundColor:
                                const Color.fromARGB(255, 75, 121, 227),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        child: const Text('Tiếp tục'),
                        // style: ElevatedButton.styleFrom(
                        //     foregroundColor:
                        //         const Color.fromARGB(255, 255, 255, 255),
                        //     backgroundColor: Color.fromARGB(162, 238, 255, 0),
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 50, vertical: 10),
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(40))),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      '-Hoặc đăng nhập bằng-',
                      style: TextStyle(
                          color: Color.fromARGB(255, 111, 111, 111),
                          fontWeight: FontWeight.w200,
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/google.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Bạn muốn đăng kí tài khoản cho cửa hàng?',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
