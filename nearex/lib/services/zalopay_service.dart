import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nearex/models/zalopay/create_order_response';
import 'package:nearex/services/customer_service.dart';
import 'package:uuid/uuid.dart';

class ZalopayConfig {
  static int appId = 2554;
  static String key1 = "sdngKKJmqEMzvh5QQcdD2A9XBSKUNaYn";
  static String key2 = "trMrHtvjo6myautxDUiAcYsVtaeQ8nhf";
  static String createOrderUrl = "https://sb-openapi.zalopay.vn/v2/create";
  static String getOrderStatusUrl = "https://sb-openapi.zalopay.vn/v2/query";
  static String getBanksUrl =
      "https://sbgateway.zalopay.vn/api/getlistmerchantbanks";
  static String redirectUrl = "";
}

class ZalopayService {
  static Future<CreateOrderResponse?> createOrder() async {
    CreateOrderResponse? createOrderResponse;
    const Uuid uuid = Uuid();
    DateTime now = DateTime.now();
    String appTransId = DateFormat('yyMMdd').format(now) + uuid.v4();
    Map<String, dynamic> body = {
      'app_id': ZalopayConfig.appId,
      'app_user': CustomerService.customer!.id,
      'app_time': now.microsecondsSinceEpoch,
      'amount': 1,
      'app_trans_id': appTransId,
      'embed_data': {},
      'item': [],
      // "callback_url": "<https://domain.com/callback>",
      'description': "Thanh toán cho đơn hàng #$appTransId",
    };
    String data =
        '${body['app_id']}|${body['app_trans_id']}|${body['app_user']}|${body['amount']}|${body['app_time']}|${body['embed_data']}|${body['item']}';
    Hmac mac = Hmac(sha256, utf8.encode(ZalopayConfig.key1));
    body["mac"] = mac.convert(utf8.encode(data)).toString();
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    Uri uri = Uri.parse(ZalopayConfig.createOrderUrl);
    Response response =
        await post(uri, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      createOrderResponse =
          CreateOrderResponse.fromJson(jsonDecode(response.body));
    }

    return createOrderResponse;

// callback_url	static String			ZaloPay sẽ thông báo trạng thái thanh toán của đơn hàng khi thanh toán hoàn tất. Nếu không được cung cấp, callback_url mặc định của ứng dụng sẽ được sử dụng.
// device_info	JSON static String	256		Chuỗi JSON mô tả thông tin của thiết bị
// sub_app_id	static String	50		Định danh dịch vụ / nhóm dịch vụ đối tác đăng ký với ZaloPay (chỉ áp dụng với một số đối tác đặc biệt)	sub123
// title	static String	256		Tiêu đề đơn hàng.
// currency	static String			Đơn vị tiền tệ. Mặc định là VND
// phone	static String	50		Số điện thoại của người dùng	0934568239
// email	static String	100		Email của người dùng	example@gmail.com
// address	static String	1024		Địa chỉ của người dùng	TPHCM
  }
}
