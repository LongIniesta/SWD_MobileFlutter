import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearex/customer/customer_campaign_details.dart';
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
  int _pageSize = 20;
  bool _isSearch = false;
  TextEditingController _searchKeyController = TextEditingController();
  late ScrollController _scrollController;
  List<Store> stores = [];
  List<Category> categories = [];
  List<Campaign> campaigns = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = DimensionValue.getScreenWidth(context);
    _screenHeight = DimensionValue.getScreenHeight(context);
    return Container(
        margin: EdgeInsets.all(_screenWidth / 24),
        // decoration: const BoxDecoration(color: ColorBackground.bubbles),
        child: CustomScrollView(controller: _scrollController, slivers: [
          // Consumer(builder: (context, value, child) {

          // },),
          SliverToBoxAdapter(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                SizedBox(
                  height: _screenWidth / 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Xin chào, $_customerName',
                          style: GoogleFonts.openSans(fontSize: 20),
                        ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: _screenWidth * 0.75,
                        child: Form(
                            child: Column(
                          children: [
                            TextFormField(
                              controller: _searchKeyController,
                              decoration: const InputDecoration(
                                  hintText: 'Tìm tên sản phẩm',
                                  prefixIcon: Icon(Icons.search)),
                              // textInputAction: TextInputAction.search,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập tên sản phẩm';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) => {
                                // setState(() {
                                //   _isSearch = true;
                                // })
                              },
                            ),
                          ],
                        ))),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorBackground.textColor1,
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
                SizedBox(
                  height: _screenWidth / 15,
                ),
                if (!_isSearch)
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
                SizedBox(
                  height: _screenWidth / 15,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Row(children: [
                Text(
                  'Đợt giảm giá hot',
                  style: GoogleFonts.openSans(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ]),
              SizedBox(
                height: _screenWidth / 15,
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
                  crossAxisCount: 2, childAspectRatio: 0.75)),
        ),
      ];
    } else {
      return [
        FutureBuilder(
            future: fetchCampaignData(),
            builder: (context, snapshot) => SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => buildCampaignView(campaigns[index])),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.5)))
      ];
    }
  }

  Widget buildCategoryView(Category category) {
    return ChoiceChip(
      label: Text(
        category.name,
        style: const TextStyle(color: Colors.black),
      ),
      selected: category.id == _selectedCategory,
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
    return InkWell(
      child: SizedBox(
        width: _screenWidth / 3,
        child: Column(children: [
          Image.network(
              'https://img.freepik.com/free-vector/shop-with-sign-we-are-open_52683-38687.jpg'),
          // Image.network(store.logo.toString()),
          Text(store.storeName.toString()),
        ]),
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Tap on store id: ${store.id}")));
      },
    );
  }

  Widget buildCampaignView(Campaign campaign) {
    return InkWell(
      child: Container(
        height: _screenHeight / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        margin: EdgeInsets.all(_screenWidth / 60),
        padding: EdgeInsets.all(_screenWidth / 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: _screenWidth / 3.3,
            child: Image.network(campaign.product.productImg),
          ),
          SizedBox(
            height: _screenWidth / 30,
          ),
          Text(
            campaign.product.productName,
            style: GoogleFonts.openSans(
                color: ColorBackground.blueberry, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: _screenWidth / 30,
          ),
          Text(
            '${campaign.discountPrice} VND',
            style: GoogleFonts.outfit(
                color: ColorBackground.blueberry, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: _screenWidth / 30,
          ),
          Text(
            '${campaign.product.price} VND',
            style: GoogleFonts.outfit(
                color: ColorBackground.textColor1,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.lineThrough),
          ),
        ]),
      ),
      onTap: () {
        Navigate.navigate(CustomerCampaignDetails(campaign: campaign), context);
      },
    );
  }

  Future<List<Category>> fetchDataFirstTimeCall() async {
    if (_timeCall == 0) {
      String? customerJson =
          await DataStorage.secureStorage.read(key: 'customer');
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
      campaigns = await CampaignService.getCampaigns(
          page: 1, pageSize: 20, startDate: DateTime.now());
      return campaigns;
    } else {
      campaigns = await CampaignService.getCampaignsByCategory(
          categoryId: _selectedCategory);
      return campaigns;
    }
  }

  Future<List<Store>> fetchStoreData() async {
    stores = await StoreService.getStores(1, 5);

    // stores = [
    //   Store(
    //       id: 0,
    //       storeName: 'storeName',
    //       phone: 'phone',
    //       address: 'address',
    //       logo: 'logo',
    //       token: 'token',
    //       coordinateString: 'coordinateString'),
    //   Store(
    //       id: 1,
    //       storeName: 'storeName',
    //       phone: 'phone',
    //       address: 'address',
    //       logo: 'logo',
    //       token: 'token',
    //       coordinateString: 'coordinateString'),
    //   Store(
    //       id: 2,
    //       storeName: 'storeName',
    //       phone: 'phone',
    //       address: 'address',
    //       logo: 'logo',
    //       token: 'token',
    //       coordinateString: 'coordinateString'),
    //   Store(
    //       id: 3,
    //       storeName: 'storeName',
    //       phone: 'phone',
    //       address: 'address',
    //       logo: 'logo',
    //       token: 'token',
    //       coordinateString: 'coordinateString'),
    //   Store(
    //       id: 4,
    //       storeName: 'storeName',
    //       phone: 'phone',
    //       address: 'address',
    //       logo: 'logo',
    //       token: 'token',
    //       coordinateString: 'coordinateString'),
    //   Store(
    //       id: 5,
    //       storeName: 'storeName',
    //       phone: 'phone',
    //       address: 'address',
    //       logo: 'logo',
    //       token: 'token',
    //       coordinateString: 'coordinateString'),
    //   Store(
    //       id: 6,
    //       storeName: 'storeName',
    //       phone: 'phone',
    //       address: 'address',
    //       logo: 'logo',
    //       token: 'token',
    //       coordinateString: 'coordinateString'),
    //   Store(
    //       id: 7,
    //       storeName: 'storeName',
    //       phone: 'phone',
    //       address: 'address',
    //       logo: 'logo',
    //       token: 'token',
    //       coordinateString: 'coordinateString'),
    //   Store(
    //       id: 8,
    //       storeName: 'storeName',
    //       phone: 'phone',
    //       address: 'address',
    //       logo: 'logo',
    //       token: 'token',
    //       coordinateString: 'coordinateString'),
    //   Store(
    //       id: 9,
    //       storeName: 'storeName',
    //       phone: 'phone',
    //       address: 'address',
    //       logo: 'logo',
    //       token: 'token',
    //       coordinateString: 'coordinateString'),
    // ];
    return stores;
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // reach the bottom
    }
  }
}
