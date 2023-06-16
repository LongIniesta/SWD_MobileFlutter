import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpComfirm extends StatefulWidget {
  const OtpComfirm({super.key});

  @override
  State<StatefulWidget> createState() {
    return OtpComfirmState();
  }
}

class OtpComfirmState extends State<OtpComfirm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        //width: double.maxFinite,
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/back.png'),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              alignment: Alignment.topLeft,
              child: const Text(
                'Xác minh',
                style: TextStyle(
                    color: Color.fromRGBO(24, 24, 35, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
              alignment: Alignment.topLeft,
              child: const Text(
                'Nhập mã được gửi đến số điện thoại **********328',
                style: TextStyle(
                    color: Color.fromRGBO(90, 90, 90, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 40,
                    width: 40,
                    child: TextFormField(
                      //textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 78, 78, 78)),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black12),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    height: 40,
                    width: 40,
                    child: TextFormField(
                      //textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 78, 78, 78)),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 40,
                    width: 40,
                    child: TextFormField(
                      //textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(
                          fontSize: 25,
                          color: const Color.fromARGB(255, 78, 78, 78)),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 40,
                    width: 40,
                    child: TextFormField(
                      //textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(
                          fontSize: 25,
                          color: const Color.fromARGB(255, 78, 78, 78)),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 40,
                    width: 40,
                    child: TextFormField(
                      //textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(
                          fontSize: 25,
                          color: const Color.fromARGB(255, 78, 78, 78)),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 40,
                    width: 40,
                    child: TextFormField(
                      //textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: const TextStyle(
                          fontSize: 25, color: Color.fromARGB(255, 78, 78, 78)),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              )),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 40,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện khi nút được nhấn
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: const Color.fromARGB(255, 75, 121, 227),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                child: const Text('Tiếp tục'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Không nhận được mã?'),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Gửi lại',
                    style: TextStyle(color: Color.fromRGBO(83, 127, 231, 1)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              
                  onTap: () {},
                  child: const Text(
                    'Hủy bỏ',
                    style: TextStyle(color: Color.fromRGBO(106, 106, 106, 1)),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
