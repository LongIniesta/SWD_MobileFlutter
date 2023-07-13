import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearex/models/campaign.dart';
import 'package:nearex/services/order_service.dart';
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
            margin: EdgeInsets.all(_screenWidth / 24),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.network(_campaign!.product.productImg),
                  Text(
                    _campaign!.product.productName,
                    style: GoogleFonts.openSans(
                        fontSize: _screenWidth / 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: _screenWidth / 30),
                  Text(
                    '${_campaign!.product.price}',
                    style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: ColorBackground.bubbles,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '${_campaign!.discountPrice}',
                    style: GoogleFonts.outfit(
                        fontSize: 20,
                        color: ColorBackground.blueberry,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(height: _screenWidth / 30),
                  Text(
                      'Chương trình áp dụng từ: ${_campaign!.startDate} - ${_campaign!.endDate}'),
                  Text('Hạn sử dụng sản phẩm: ${_campaign!.startDate}'),
                  Text('Đơn vị bán: ${_campaign!.product.unit}'),
                  Text(
                      'Số lượng ít nhất để đặt mua: ${_campaign!.minQuantity}'),
                  Text('Mô tả sản phẩm: ${_campaign!.product.description}'),
                  Text('Sản xuất tại: ${_campaign!.product.origin}'),
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
              OrderService.saveOrder(_quantity, _campaign!.id, 1);
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
