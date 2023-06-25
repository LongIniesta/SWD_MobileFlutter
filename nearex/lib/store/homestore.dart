import 'package:flutter/material.dart';
import 'package:nearex/store/accountstore.dart';
import 'package:nearex/store/campaignstore.dart';
import 'package:nearex/store/orderstore.dart';
import 'package:nearex/store/productstore.dart';
import 'package:nearex/store/startstorescreen.dart';
class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: <Widget>[
          StartStoreScreen() ,
          CapaignStoreScreen(),
          ProductStoreScreen(),
          OrderStoreScreen(),
          AccountStoreScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 78, 78, 78),
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromARGB(255, 8, 8, 8),
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('images/trangchu.png'),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/dothang.png'),
            label: 'Đợt hàng',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/sanpham.png'),
            label: 'Sản phẩm',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/donhang.png'),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/taikhoan.png'),
            label: 'Tài khoảng',
          ),
        ],
      ),
    );
  }
}
