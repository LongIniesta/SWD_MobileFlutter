import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nearex/model/store.dart';
import 'package:http/http.dart' as http;

import '../model/report.dart';

class StartStoreScreen extends StatefulWidget {
  StartStoreScreen({super.key, required this.store});
  Store store;

  @override
  State<StatefulWidget> createState() {
    return StartStoreScreenState(store);
  }
}

class StartStoreScreenState extends State<StartStoreScreen> {
  Store store;
  Report report = Report(
      toTalCampaign: 0,
      totalAmount: 0,
      totalCustomer: 0,
      totalOrder: 0,
      totalProduct: 0);
  StartStoreScreenState(this.store);
  Future<void> loadReport() async {
    var url = Uri.parse(
        'https://swd-nearex.azurewebsites.net/api/stores/report-in-range?StoreId=${store.id}');
    try {
     http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${store.token}'
        },
      );
      if (response.statusCode == 200) {
        String jsonString = response.body;
        Map<String, dynamic> jsonData = json.decode(response.body.toString());
        Report reportD = Report(
            toTalCampaign: jsonData['toTalCampaign'],
            totalAmount: double.parse(jsonData['totalAmount'].toString()),
            totalCustomer: jsonData['totalCustomer'],
            totalOrder: jsonData['totalOrder'],
            totalProduct: jsonData['totalProduct']);
        setState(() {
          report = reportD;
        });
      }

      // ignore: empty_catches
    } catch (e) {}
  }


  @override
  void initState() {
    loadReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Xin chào ' + store.storeName!,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Màu chữ
                letterSpacing: 1.5, // Khoảng cách giữa các chữ cái
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0,
                    color: Colors.grey.withOpacity(0.5), // Màu của bóng chữ
                  ),
                ],
              ),
            ),
            ReportCard(
                title: 'Tổng số đơn hàng', value: report.totalOrder.toString()),
            ReportCard(
                title: 'Tổng doanh thu',
                value: '${report.totalAmount!.toStringAsFixed(0)} vnđ'),
            ReportCard(
                title: 'Tổng số đợt giảm giá', value: report.toTalCampaign.toString()),
            ReportCard(
                title: 'Tổng số sản phẩm', value: report.totalProduct.toString()),
            ReportCard(
                title: 'Tổng số khách hàng', value: report.totalCustomer.toString()),
          ],
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final String value;

  ReportCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(45.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
