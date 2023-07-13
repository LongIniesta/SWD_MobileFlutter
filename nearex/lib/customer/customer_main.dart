import 'package:flutter/material.dart';
import 'package:nearex/customer/customer_home.dart';
import 'package:nearex/customer/customer_order.dart';
import 'package:nearex/customer/customer_profile.dart';
import 'package:nearex/utils/data_storage.dart';

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
    const CustomerOrder(),
    const CustomerProfile()
  ];
  int _currentIndex = 0;
  void _onDestinationSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    DataStorage.secureStorage.write(
        key: 'customerJwt',
        value:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJuYW1laWQiOiI5Iiwicm9sZSI6ImN1c3RvbWVyIiwidW5pcXVlX25hbWUiOiJMeSIsImVtYWlsIjoibHluZ28xMjk0QGdtYWlsLmNvbSIsIkZjbVRva2VuIjoiIiwiSW1hZ2VVcmwiOiIiLCJHb29nbGVJZCI6IiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL21vYmlsZXBob25lIjoiMDk3MTE4NjQ2NyIsIm5iZiI6MTY4OTIzNzAyNSwiZXhwIjoxNzIwODU5NDI1LCJpYXQiOjE2ODkyMzcwMjV9.52g3tvH1wKoMiinoKElIhoQm4-rEiqxG3yHnHOOT1bk');
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
              backgroundColor: Colors.white,
            ),
            body: _screens[_currentIndex]));
  }
}
