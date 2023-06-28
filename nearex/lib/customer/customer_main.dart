import 'package:flutter/material.dart';
import 'package:nearex/customer/customer_home.dart';
import 'package:nearex/customer/customer_order.dart';
import 'package:nearex/customer/customer_profile.dart';

class MainCustomer extends StatefulWidget {
  const MainCustomer({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainCustomerState();
  }
}

class _MainCustomerState extends State<MainCustomer> {
  final List<Widget> _screens = [
    const HomeCustomer(),
    const CustomerProfile(),
    const CustomerOrder()
  ];
  int _currentIndex = 0;
  void _onDestinationSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            bottomNavigationBar: NavigationBar(
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.home_filled), label: 'Trang chủ'),
                NavigationDestination(
                    icon: Icon(Icons.history), label: 'Đơn hàng'),
                NavigationDestination(
                    icon: Icon(Icons.person), label: 'Tài khoản'),
              ],
              selectedIndex: _currentIndex,
              onDestinationSelected: _onDestinationSelected,
            ),
            body: _screens[_currentIndex]));
  }
}
