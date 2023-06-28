import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearex/customer/customer_notification.dart';
import 'package:nearex/models/category.dart';
import 'package:nearex/models/customer.dart';
import 'package:nearex/models/store.dart';
import 'package:nearex/services/category_service.dart';
import 'package:nearex/utils/common_widget.dart';
import 'package:nearex/utils/data_storage.dart';

class HomeCustomer extends StatefulWidget {
  const HomeCustomer({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeCustomerState();
  }
}

class _HomeCustomerState extends State<HomeCustomer> {
  String? _customerName = '';
  double _screenWidth = 0;
  double _screenHeight = 0;
  List<Store> stores = [];
  List<Category> categories = [];
  @override
  Widget build(BuildContext context) {
    initData();
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text('Xin chào, $_customerName'),
                  // get location nha
                ],
              ),
              IconButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CustomerNotification()))
                      },
                  icon: const FaIcon(FontAwesomeIcons.bell))
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.sliders)) //filter
            ],
          ),
          Row(
            children: [
              Text('Cửa hàng gần bạn'),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Xem tất cả',
                    style: GoogleFonts.inter(
                        fontSize: 10, color: ColorBackground.blueberry),
                  ))
            ],
          ),
          // SizedBox(
          //   height: _screenHeight / 4,
          //   child: ListView.builder(
          //     itemBuilder: (context, index) => buildStoreView(stores[index]),
          //     itemCount: 5,
          //     scrollDirection: Axis.horizontal,
          //   ),
          // ),
          Text('Đợt giảm giá hot'),
          // ListView.builder(
          //   itemBuilder: (context, index) => buildCampaignView(),
          // )
        ],
      ),
    );
  }

  Widget buildStoreView(Store store) {
    return Container(
      width: _screenWidth / 3,
      child: Column(children: [
        Image.network(store.logo.toString()),
        Text(store.storeName.toString()),
      ]),
    );
  }

  // Widget buildCampaignView(Campaign campaign) {
  //   return Container(
  //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
  //     width: _screenWidth * 0.4,
  //     child: Column(children: [Image.network(src)]),
  //   );
  // }

  void initData() async {
    _screenWidth = DimensionValue.getScreenWidth(context);
    _screenHeight = DimensionValue.getScreenHeight(context);
    String? customerJson = await DataStorage.storage.read(key: 'customer');
    if (customerJson != null) {
      _customerName = Customer.fromJson(jsonDecode(customerJson)).userName;
    }
    categories = await CategoryService.getCategories();
  }
}
