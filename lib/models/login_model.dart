class ShopLoginMoDel {
  bool? status;
  String message = 'null';
  UserData? data;
  ShopLoginMoDel.fromjson(Map<String, dynamic?>? json) {
    status = json!['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromjson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? massage;
  String? emial;
  String? name;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  UserData({
    this.id,
    this.emial,
    this.name,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  }) {}
  UserData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    emial = json['emial'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
