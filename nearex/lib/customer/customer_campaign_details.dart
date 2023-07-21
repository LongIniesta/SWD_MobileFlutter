import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nearex/customer/customer_campaign_purchase.dart';
import 'package:nearex/models/campaign.dart';
import 'package:nearex/utils/common_widget.dart';

class CustomerCampaignDetails extends StatefulWidget {
  // final int campaignId;
  // const CustomerCampaignDetails({super.key, required this.campaignId});

  final Campaign campaign;
  const CustomerCampaignDetails({super.key, required this.campaign});

  @override
  State<StatefulWidget> createState() {
    // campaign = await CampaignService.getCampaignById(campaignId);
    return _CustomerCampaignDetailsState();
  }
}

class _CustomerCampaignDetailsState extends State<CustomerCampaignDetails> {
  Campaign? _campaign;
  int _quantity = 1;

  double _screenWidth = 0;
  // double _screenHeight = 0;
  @override
  Widget build(BuildContext context) {
    _screenWidth = DimensionValue.getScreenWidth(context);
    // _screenHeight = DimensionValue.getScreenHeight(context);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _getCampaign(),
        builder: (context, snapshot) => SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(_screenWidth / 18),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(_campaign!.product.productImg),
                  SizedBox(height: _screenWidth / 30),
                  Text(
                    _campaign!.product.productName,
                    style: GoogleFonts.openSans(
                        fontSize: _screenWidth / 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: _screenWidth / 30),
                  Text(
                    '${_campaign!.discountPrice} VND',
                    style: GoogleFonts.outfit(
                        fontSize: 20,
                        color: ColorBackground.blueberry,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '${_campaign!.product.price} VND',
                    style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: ColorBackground.textColor1,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(height: _screenWidth / 30),
                  Text(
                    'Chương trình áp dụng từ:',
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: _screenWidth / 60),
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(_campaign!.startDate)} - ${DateFormat('dd/MM/yyyy').format(_campaign!.endDate)}',
                    style: GoogleFonts.openSans(),
                  ),
                  SizedBox(height: _screenWidth / 30),
                  Text(
                    'Hạn sử dụng sản phẩm:',
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: _screenWidth / 60),
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(_campaign!.startDate)}',
                    style: GoogleFonts.openSans(),
                  ),
                  SizedBox(height: _screenWidth / 30),
                  Text('Đơn vị bán: ${_campaign!.product.unit}'),
                  SizedBox(height: _screenWidth / 30),
                  Text(
                      'Số lượng ít nhất để đặt mua: ${_campaign!.minQuantity}'),
                  SizedBox(height: _screenWidth / 30),
                  Text(
                    'Mô tả sản phẩm:',
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: _screenWidth / 60),
                  Text(_campaign!.product.description,
                      style: GoogleFonts.openSans()),
                  SizedBox(height: _screenWidth / 30),
                  Text('Sản xuất tại:',
                      style: GoogleFonts.openSans(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: _screenWidth / 60),
                  Text('${_campaign!.product.origin}',
                      style: GoogleFonts.openSans())
                ]),
          ),
        ),
      ),
      persistentFooterButtons: [
        IconButton(
            onPressed: () {
              if (_quantity > _campaign!.minQuantity) {
                setState(() {
                  _quantity -= 1;
                });
              }
            },
            icon: Icon(Icons.remove_circle_outline)),
        Text(_quantity.toString()),
        IconButton(
            onPressed: () {
              if (_quantity < _campaign!.quantity) {
                setState(() {
                  _quantity += 1;
                });
              }
            },
            icon: Icon(Icons.add_circle_outline)),
        TextButton(
            onPressed: () {
              Navigate.navigate(
                  CustomerCampaignPurchase(
                      campaign: _campaign, quantity: _quantity),
                  context);
            },
            child: const Text("Đặt mua"))
      ],
    );
  }

  Future<Campaign?> _getCampaign() async {
    // _campaign = await CampaignService.getCampaignById(widget.campaignId);
    // return _campaign;
    _campaign = widget.campaign;
    return _campaign;
  }
}
