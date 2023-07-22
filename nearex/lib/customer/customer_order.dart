import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearex/models/order.dart';
import 'package:nearex/services/customer_service.dart';
import 'package:nearex/services/order_service.dart';
import 'package:nearex/utils/common_widget.dart';

class CustomerOrder extends StatefulWidget {
  const CustomerOrder({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomerOrderState();
  }
}

class _CustomerOrderState extends State<CustomerOrder> {
  List<Order> orders = [];
  late double _screenWidth;
  @override
  Widget build(BuildContext context) {
    _screenWidth = DimensionValue.getScreenWidth(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Trạng thái đơn hàng'),
            // segmented control for ios, tabbar for android?
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Đã đặt hàng',
              ),
              Tab(
                text: 'Đã nhận',
              )
            ]),
          ),
          body: Container(
            width: _screenWidth / 5 * 4,
            margin: EdgeInsets.all(_screenWidth / 24),
            child: Expanded(
                child: TabBarView(children: [
              // SingleChildScrollView(
              //   child:
              FutureBuilder(
                future: _getOrders(3),
                builder: (context, snapshot) => ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) =>
                      buildOrderView(orders[index]),
                  itemCount: orders.length,
                ),
              ),
              // ),
              // SingleChildScrollView(
              //   child:
              FutureBuilder(
                future: _getOrders(1),
                builder: (context, snapshot) => ListView.builder(
                  itemBuilder: (context, index) =>
                      buildOrderView(orders[index]),
                  itemCount: orders.length,
                ),
              ),
              // ),
            ])),
          ),
        ));
  }

  Future<List<Order>> _getOrders(int status) async {
    orders = await OrderService.getOrders(
        customerId: CustomerService.customer!.id,
        page: 1,
        pageSize: 10,
        status: status);
    return orders;
  }

  Widget buildOrderView(Order order) {
    return InkWell(
      child: Container(
        height: _screenWidth / 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        margin: EdgeInsets.all(_screenWidth / 60),
        padding: EdgeInsets.all(_screenWidth / 30),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: _screenWidth / 5,
                child: Image.asset('images/icon_food.png'),
              ),
              SizedBox(
                width: _screenWidth / 30,
              ),
              Column(
                children: [
                  Text(
                    'sda', // '${order.storename}',
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: _screenWidth / 30,
                  ),
                  Text(
                    '${order.orderDate}',
                    style: GoogleFonts.openSans(),
                  ),
                ],
              ),
              SizedBox(
                width: _screenWidth / 30,
              ),
              Text(
                'price', //'${order.unitPrice}',
                style: GoogleFonts.openSans(),
              ),
            ]),
      ),
      onTap: () {
        // Navigate.navigate(, context);
      },
    );
  }
}
