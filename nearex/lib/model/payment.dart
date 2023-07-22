class Payments {
  int? id;
  String? method;
  int? status;
  DateTime? time;
  int? orderId;

  Payments({this.id, this.method, this.status, this.time, this.orderId});

  Payments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    method = json['method'];
    status = json['status'];
    time = DateTime.parse(json['time']);
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['method'] = method;
    data['status'] = status;
    data['time'] = time;
    data['orderId'] = orderId;
    return data;
  }
}
