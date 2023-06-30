import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearex/customer/customer_notification.dart';
import 'package:nearex/models/campaign.dart';
import 'package:nearex/models/category.dart';
import 'package:nearex/models/product.dart';
import 'package:nearex/models/store.dart';
import 'package:nearex/utils/common_widget.dart';

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
                SizedBox(
                  height: _screenWidth / 15,
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
    // if (_timeCall == 0) {
    //   String? customerJson = await DataStorage.storage.read(key: 'customer');
    //   if (customerJson != null) {
    //     _customerName = Customer.fromJson(jsonDecode(customerJson)).userName;
    //   }
    //   categories.add(Category(id: 0, name: 'Tất cả'));
    //   categories.addAll(await CategoryService.getCategories());
    //   _timeCall = 1;
    // }

    // fake dữ liệu để test cho nhanh, call api lâu quá
    categories = [
      Category(id: 0, name: 'Tất cả'),
      Category(id: 1, name: 'Thịt cá'),
      Category(id: 2, name: 'Rau củ'),
      Category(id: 3, name: 'Hoa quả'),
      Category(id: 4, name: 'Đồ uống'),
      Category(id: 5, name: 'Thực phẩm ăn liền'),
      Category(id: 6, name: 'Thực phẩm khô'),
      Category(id: 7, name: 'Bánh kẹo'),
      Category(id: 8, name: 'Sữa'),
      Category(id: 9, name: 'Hải sản'),
    ];
    return categories;
  }

  Future<List<Campaign>> fetchCampaignData() async {
    // if (_selectedCategory == 0) {
    //   campaigns = await CampaignService.getCampaigns(1, 20);
    //   return campaigns;
    // } else {
    //   campaigns = await CampaignService.getCampaignsByCategory(
    //       1, 20, _selectedCategory);
    // return campaigns;
    // }

    campaigns = [
      Campaign(
          id: 0,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 1,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 2,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 3,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 4,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 5,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 6,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 7,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 8,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 9,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 10,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 11,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 12,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 13,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 14,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 15,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 16,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 17,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 18,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 19,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 20,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
      Campaign(
          id: 21,
          startDate: DateTime(2023, 6, 30),
          endDate: DateTime(2023, 7, 31),
          status: 0,
          exp: DateTime(2023, 8, 31),
          product: Product(
              id: 0,
              price: 100000,
              origin: 'origin',
              productImg: 'productImg',
              productName: 'productName',
              description: 'description',
              unit: 'gam',
              netWeight: 680),
          quantity: 100),
    ];
    return campaigns;
  }

  Future<List<Store>> fetchStoreData() async {
    // stores = await StoreService.getStores(1, 5);

    stores = [
      Store(
          id: 0,
          storeName: 'storeName',
          phone: 'phone',
          address: 'address',
          logo: 'logo',
          token: 'token',
          coordinateString: 'coordinateString'),
      Store(
          id: 1,
          storeName: 'storeName',
          phone: 'phone',
          address: 'address',
          logo: 'logo',
          token: 'token',
          coordinateString: 'coordinateString'),
      Store(
          id: 2,
          storeName: 'storeName',
          phone: 'phone',
          address: 'address',
          logo: 'logo',
          token: 'token',
          coordinateString: 'coordinateString'),
      Store(
          id: 3,
          storeName: 'storeName',
          phone: 'phone',
          address: 'address',
          logo: 'logo',
          token: 'token',
          coordinateString: 'coordinateString'),
      Store(
          id: 4,
          storeName: 'storeName',
          phone: 'phone',
          address: 'address',
          logo: 'logo',
          token: 'token',
          coordinateString: 'coordinateString'),
      Store(
          id: 5,
          storeName: 'storeName',
          phone: 'phone',
          address: 'address',
          logo: 'logo',
          token: 'token',
          coordinateString: 'coordinateString'),
      Store(
          id: 6,
          storeName: 'storeName',
          phone: 'phone',
          address: 'address',
          logo: 'logo',
          token: 'token',
          coordinateString: 'coordinateString'),
      Store(
          id: 7,
          storeName: 'storeName',
          phone: 'phone',
          address: 'address',
          logo: 'logo',
          token: 'token',
          coordinateString: 'coordinateString'),
      Store(
          id: 8,
          storeName: 'storeName',
          phone: 'phone',
          address: 'address',
          logo: 'logo',
          token: 'token',
          coordinateString: 'coordinateString'),
      Store(
          id: 9,
          storeName: 'storeName',
          phone: 'phone',
          address: 'address',
          logo: 'logo',
          token: 'token',
          coordinateString: 'coordinateString'),
    ];
    return stores;
  }

  @override
  void initState() {
    super.initState();
  }
}
