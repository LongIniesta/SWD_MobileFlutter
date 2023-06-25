import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderStoreScreen extends StatefulWidget{
  const OrderStoreScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return OrderStoreScreenState();
  }

}

class OrderStoreScreenState extends State<OrderStoreScreen>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration:
            const BoxDecoration(color: Color.fromRGBO(233, 248, 249, 1)),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50, left: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Đơn hàng của T_mart',
                          style: GoogleFonts.sourceSansPro(
                            color: Colors.black,
                            fontSize: 25,
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50, right: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {},
                        child: Image.asset(
                          'images/notificationbig.png',
                          width: 25,
                          height: 25,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 5),
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  height: 45,
                  width: 330,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Tim kiem',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          print('search');
                        },
                        child: const Icon(Icons.search),
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {},
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                         builder: (context) =>
                    //                             AddNewCampaignScreen()));
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 21, 23, 41),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: const EdgeInsets.only(top: 10, left: 5, right: 20),
                    child: Icon(
                      Icons.add,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              height: 50,
              width: double.maxFinite,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      height: 40,
                      width: 70,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromRGBO(24, 24, 35, 1),
                      ),
                      child: Text(
                        'Tat ca',
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      height: 40,
                      width: 70,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Text(
                        'Hôm nay',
                        style: GoogleFonts.sourceSansPro(
                            color: const Color.fromRGBO(24, 24, 35, 1),
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      height: 40,
                      width: 70,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Text(
                        'Tuần này',
                        style: GoogleFonts.sourceSansPro(
                            color: const Color.fromRGBO(24, 24, 35, 1),
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      height: 40,
                      width: 70,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Text(
                        'Tháng này',
                        style: GoogleFonts.sourceSansPro(
                            color: const Color.fromRGBO(24, 24, 35, 1),
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      height: 40,
                      width: 70,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Text(
                        'Năm nay',
                        style: GoogleFonts.sourceSansPro(
                            color: const Color.fromRGBO(24, 24, 35, 1),
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 20),
                height: 600,
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.maxFinite,
                        height: 200,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: Container(
                          width: double.maxFinite,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             DetailCampaignScreen()));
                                  },
                                  child: Icon(Icons.edit, size: 35),
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'images/product.png',
                                    width: 150,
                                    height: double.maxFinite,
                                    fit: BoxFit.contain,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Thùng 24 gói mì Cung Đình lẩu tôm chua cay',
                                          style: GoogleFonts.sourceSansPro(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Khách hàng: Nguyễn Messi',
                                          style: GoogleFonts.sourceSansPro(
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        
                                        Text(
                                          'SĐT: 0929828328',
                                          style: GoogleFonts.sourceSansPro(
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Đặt lúc: 12:12:12 28/05/2023',
                                          style: GoogleFonts.sourceSansPro(
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Số lượng: 12',
                                          style: GoogleFonts.sourceSansPro(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Chưa nhận hàng',
                                          style: GoogleFonts.sourceSansPro(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 247, 131, 131)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

}