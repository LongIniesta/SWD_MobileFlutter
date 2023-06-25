import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearex/store/addcampaigndetail.dart';

class EditCampaignScreen extends StatefulWidget {
  const EditCampaignScreen({super.key});

  @override
  State<EditCampaignScreen> createState() => _EditCampaignScreenState();
}

class _EditCampaignScreenState extends State<EditCampaignScreen> {
  DateTime dateEnd = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color.fromRGBO(233, 248, 249, 1),
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
                  margin: EdgeInsets.only(top: 65),
                  child: Text(
                    'Chỉnh sửa đợt giảm giá',
                    style: GoogleFonts.outfit(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 15, 14, 36)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.maxFinite,
                  height: 650,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            'Ngày kết thúc',
                            style: GoogleFonts.outfit(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: InkWell(
                              onTap: () {
                                _showDatePicker();
                              },
                              child: TextField(
                                enabled: false,
                                keyboardType: TextInputType.phone,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  hintText:
                                      '${dateEnd.day}/${dateEnd.month}/${dateEnd.year}',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(color: const Color.fromARGB(255, 175, 204, 255), 
                          borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: 200,
                                      child: Text(
                                        'Bắt đầu áp dụng từ',
                                        style: GoogleFonts.outfit(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        '30/04/2023',
                                        style: GoogleFonts.outfit(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 20, top: 10),
                                      width: 200,
                                      child: Text(
                                        'Giá giảm còn',
                                        style: GoogleFonts.outfit(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: 100,
                                      child: Text(
                                        '233,000 đ',
                                        style: GoogleFonts.outfit(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 20, top: 10),
                                      width: 200,
                                      child: Text(
                                        'Số lượng đặt mua tối thiểu',
                                        style: GoogleFonts.outfit(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: 100,
                                      child: Text(
                                        '12',
                                        style: GoogleFonts.outfit(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 117, 191, 252),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text('Lưu', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 255, 255, 255)),),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCampaignDetailScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10, bottom: 90),
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Icon(Icons.add, color: Colors.white,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: dateEnd,
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        dateEnd = value!;
      });
    });
  }
}
