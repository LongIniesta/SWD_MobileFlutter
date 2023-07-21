import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nearex/models/campaign.dart';
import 'package:nearex/services/customer_service.dart';
import 'package:nearex/services/order_service.dart';
import 'package:nearex/services/zalopay_service.dart';
import 'package:nearex/utils/common_widget.dart';

class CustomerCampaignPurchase extends StatefulWidget {
  // final int campaignId;
  final Campaign? campaign;
  final int quantity;
  const CustomerCampaignPurchase(
      {required this.campaign, required this.quantity, super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomerCampaignPurchaseState();
  }
}

class _CustomerCampaignPurchaseState extends State<CustomerCampaignPurchase> {
  String _selectedPaymentMethod = 'COD';
  late double _screenWidth;
  static const EventChannel eventChannel =
      EventChannel('flutter.native/eventPayOrder');
  static const MethodChannel platform =
      MethodChannel('flutter.native/channelPayOrder');
  // Campaign? _campaign;
  String zpTransToken = "";
  String payResult = "";
  String payAmount = "10000";
  bool showResult = false;
  String zpToken = "";
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
    }
  }

  void _onEvent(dynamic event) {
    var res = Map<String, dynamic>.from(event);
    setState(() {
      if (res["errorCode"] == 1) {
        payResult = "Thanh toán thành công";
      } else if (res["errorCode"] == 4) {
        payResult = "User hủy thanh toán";
      } else {
        payResult = "Giao dịch thất bại";
      }
    });
  }

  void _onError(Object error) {
    setState(() {
      payResult = "Giao dịch thất bại";
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = DimensionValue.getScreenWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body:
          // FutureBuilder(
          //   future: getCampaign(),
          //   builder: (context, snapshot) =>
          Container(
        margin: EdgeInsets.all(_screenWidth / 24),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Địa chỉ cửa hàng',
                style: GoogleFonts.openSans(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: _screenWidth / 30),
              Text('${widget.campaign!.product.store.address}',
                  style: GoogleFonts.openSans()),
              SizedBox(height: _screenWidth / 30),
              Text('Thời gian lấy hàng',
                  style: GoogleFonts.openSans(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: _screenWidth / 30),
              Text(
                  '${DateFormat('dd/MM/yyyy').format(widget.campaign!.startDate)} - ${DateFormat('dd/MM/yyyy').format(widget.campaign!.endDate)}',
                  style: GoogleFonts.openSans()),
              SizedBox(height: _screenWidth / 30),
              Text('Phương thức thanh toán',
                  style: GoogleFonts.openSans(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: _screenWidth / 30),
              DropdownButton(
                  value: _selectedPaymentMethod,
                  items: [
                    DropdownMenuItem(
                      enabled: true,
                      value: 'COD',
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(Icons.attach_money_sharp),
                          ),
                          Text('Thanh toán bằng tiền mặt khi nhận hàng',
                              style: GoogleFonts.openSans())
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                        value: 'Zalopay',
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration:
                                  BoxDecoration(border: Border.symmetric()),
                              child: Image.asset('images/icon_zalopay.png'),
                            ),
                            Text('Zalopay', style: GoogleFonts.openSans())
                          ],
                        ))
                  ],
                  onChanged: (value) => {
                        setState(() {
                          _selectedPaymentMethod = value as String;
                        })
                      }),
              SizedBox(height: _screenWidth / 30),
              Text('Sản phẩm',
                  style: GoogleFonts.openSans(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: _screenWidth / 30),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(_screenWidth / 30))),
                padding: EdgeInsets.all(_screenWidth / 24),
                child: Row(children: [
                  SizedBox(
                      width: _screenWidth / 3,
                      child: Image.network(widget.campaign!.product.productImg,
                          fit: BoxFit.fitWidth)),
                  Expanded(
                      child: Container(
                          width: _screenWidth * 2 / 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.campaign!.product.productName,
                                  style: GoogleFonts.openSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(DateFormat('dd/MM/yyyy')
                                  .format(widget.campaign!.exp)),
                              Text(
                                '${widget.campaign!.product.price}',
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                              Text('${widget.campaign!.discountPrice}'),
                              Text('${widget.quantity}')
                            ],
                          )))
                ]),
              ),
              Text(
                  'Tổng cộng: ${widget.quantity * widget.campaign!.product.price} VND'),
              Text(
                  'Giảm giá: ${widget.quantity * (widget.campaign!.product.price - widget.campaign!.discountPrice)} VND'),
              Text(
                  'Thành tiền: ${widget.quantity * widget.campaign!.discountPrice} VND')
            ]),
      ),
      // ),
      persistentFooterButtons: [
        TextButton(
            onPressed: _order,
            child: const Text(
              'Đặt hàng',
              textAlign: TextAlign.center,
            ))
      ],
    );
  }

  // Future<Campaign?> getCampaign() async {
  //   _campaign = await CampaignService.getCampaignById(widget.campaignId);
  //   return _campaign;
  // }
  void _order() async {
    if (_selectedPaymentMethod == 'Zalopay') {
      await ZalopayService.createOrder();
      String response = "";
      try {
        final String result =
            await platform.invokeMethod('payOrder', {"zptoken": zpToken});
        response = result;
        print("payOrder Result: '$result'.");
      } on PlatformException catch (e) {
        print("Failed to Invoke: '${e.message}'.");
        response = "Thanh toán thất bại";
      }
      print(response);
      setState(() {
        payResult = response;
      });
      await OrderService.saveOrder(
          quantity: widget.quantity,
          campaignId: widget.campaign!.id,
          customerId: CustomerService.customer!.id,
          paymentMethod: _selectedPaymentMethod);
    } else {
      await OrderService.saveOrder(
          quantity: widget.quantity,
          campaignId: widget.campaign!.id,
          customerId: CustomerService.customer!.id,
          paymentMethod: _selectedPaymentMethod);
    }
  }
}
