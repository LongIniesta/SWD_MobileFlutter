import 'package:flutter/material.dart';
import 'package:nearex/utils/common_widget.dart';

class CustomerOrder extends StatefulWidget {
  const CustomerOrder({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomerOrderState();
  }
}

class _CustomerOrderState extends State<CustomerOrder> {
  late double _screenHeight;
  late double _screenWidth;
  @override
  Widget build(BuildContext context) {
    _screenHeight = DimensionValue.getScreenHeight(context);
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
            margin: EdgeInsets.all(_screenWidth / 24),
            child: Expanded(
                child: TabBarView(children: [
              Center(
                child: Text('page 1'),
              ),
              Center(
                child: Text('page 2'),
              )
            ])),
          ),
        ));
  }
}
