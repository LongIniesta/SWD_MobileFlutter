import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearex/customer/customer_notification.dart';
import 'package:nearex/models/campaign.dart';
import 'package:nearex/models/category.dart';
import 'package:nearex/models/customer.dart';
import 'package:nearex/models/store.dart';
import 'package:nearex/services/campaign_service.dart';
import 'package:nearex/services/category_service.dart';
import 'package:nearex/services/store_service.dart';
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
  int _timeCall = 0;
  String? _customerName = '';
  double _screenWidth = 0;
  double _screenHeight = 0;
  int _selectedCategory = 0;
  List<Store> stores = [];
  List<Category> categories = [];
  List<Campaign> campaigns = [];

  @override
  Widget build(BuildContext context) {
    _screenWidth = DimensionValue.getScreenWidth(context);
    _screenHeight = DimensionValue.getScreenHeight(context);
    return Container(
        margin: EdgeInsets.all(_screenWidth / 24),
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        onPressed: () => Navigate.navigate(
                            const CustomerNotification(), context),
                        icon: const FaIcon(FontAwesomeIcons.bell))
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: _screenWidth * 0.75,
                      child: const TextField(
                        decoration:
                            InputDecoration(hintText: 'Tìm tên sản phẩm'),
                        textInputAction: TextInputAction.search,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorBackground.eerieBlack,
                          borderRadius: BorderRadius.circular(5)),
                      child: IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.sliders,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                FutureBuilder(
                  future: fetchDataFirstTimeCall(),
                  builder: (context, snapshot) => SizedBox(
                    height: _screenHeight / 22,
                    child: ListView.separated(
                      itemBuilder: (context, index) =>
                          buildCategoryView(categories[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ])),
          ...buildMainView()
        ]));
  }

  List<Widget> buildMainView() {
    if (_selectedCategory == 0) {
      return [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('Cửa hàng gần bạn',
                      style: GoogleFonts.openSans(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {
                        // navigate den list store
                      },
                      child: Text(
                        'Xem tất cả',
                        style: GoogleFonts.inter(
                            fontSize: 12, color: ColorBackground.blueberry),
                      ))
                ],
              ),
              FutureBuilder(
                future: fetchStoreData(),
                builder: (context, snapshot) => SizedBox(
                  height: _screenHeight / 4,
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        buildStoreView(stores[index]),
                    itemCount: stores.length > 5 ? 5 : stores.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 12,
                    ),
                  ),
                ),
              ),
              Text(
                'Đợt giảm giá hot',
                style: GoogleFonts.openSans(
                    fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: fetchCampaignData(),
          builder: (context, snapshot) => SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return buildCampaignView(campaigns[index]);
              }, childCount: campaigns.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2)),
        )
      ];
    } else {
      return [
        FutureBuilder(
            future: fetchCampaignData(),
            builder: (context, snapshot) => SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => buildCampaignView(campaigns[index]),
                    childCount: campaigns.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2)))
      ];
    }
  }

  Widget buildCategoryView(Category category) {
    return ChoiceChip(
      label: Text(
        category.name,
        style: const TextStyle(color: Colors.black),
      ),
      selected: category.id == 0,
      selectedColor: ColorBackground.blueberry,
      backgroundColor: ColorBackground.diamond,
      onSelected: (value) {
        setState(() {
          value = true;
          _selectedCategory = category.id;
        });
      },
    );
  }

  Widget buildStoreView(Store store) {
    return SizedBox(
      width: _screenWidth / 3,
      child: Column(children: [
        Image.network(
            'https://img.freepik.com/premium-vector/online-shop-logo-shopping-shop-logo_664675-1016.jpg'),
        // Image.network(store.logo.toString()),
        Text(store.storeName.toString()),
      ]),
    );
  }

  Widget buildCampaignView(Campaign campaign) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      width: _screenWidth * 0.4,
      child: Column(children: [
        SizedBox(
            width: _screenWidth / 3.3,
            child: Image.network(
                'https://img.freepik.com/free-vector/white-product-podium-with-green-tropical-palm-leaves-golden-round-arch-green-wall_87521-3023.jpg')
            // Image.network(campaign.product.productImg),
            ),
        Text(campaign.product.productName)
      ]),
    );
  }

  Future<List<Category>> fetchDataFirstTimeCall() async {
    if (_timeCall == 0) {
      String? customerJson = await DataStorage.storage.read(key: 'customer');
      if (customerJson != null) {
        _customerName = Customer.fromJson(jsonDecode(customerJson)).userName;
      }
      categories.add(Category(id: 0, name: 'Tất cả'));
      categories.addAll(await CategoryService.getCategories());
      _timeCall = 1;
    }
    return categories;
  }

  Future<List<Campaign>> fetchCampaignData() async {
    if (_selectedCategory == 0) {
      campaigns = await CampaignService.getCampaigns(1, 20);
      return campaigns;
    } else {
      campaigns = await CampaignService.getCampaignsByCategory(
          1, 20, _selectedCategory);
      return campaigns;
    }
  }

  Future<List<Store>> fetchStoreData() async {
    stores = await StoreService.getStores(1, 5);
    return stores;
  }

  @override
  void initState() {
    super.initState();
  }
}
