class CreateOrderResponse {
  final String? zptranstoken;
  final String? orderurl;
  final int? returncode;
  final String? returnmessage;
  final int? subreturncode;
  final String? subreturnmessage;
  final String? ordertoken;
  
  CreateOrderResponse(
      {this.zptranstoken, this.orderurl, this.returncode, this.returnmessage, this.subreturncode, this.subreturnmessage, this.ordertoken});

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponse(
      zptranstoken: json['zp_trans_token'],
      orderurl: json['order_url'],
      returncode: json['return_code'],
      returnmessage: json['return_message'],
      subreturncode: json['sub_return_code'],
      subreturnmessage: json['sub_return_message'],
      ordertoken: json["order_token"],
    );
  }
}