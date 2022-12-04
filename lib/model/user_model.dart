class UserResponse {
  String? url;
  String? name;
  int? phone;
  String? area;
  String? address;
  String? city;
  String? state;
  int? zip;
  String? email;
  String? birthDate;

  UserResponse(
      {this.phone,
      this.area,
      this.url,
      this.address,
      this.city,
      this.state,
      this.zip,
      this.email,
      this.birthDate,
      this.name});

  UserResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    phone = json['phone'];
    area = json['area'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    email = json['email'];
    birthDate = json['birthDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['name'] = name;
    data['phone'] = phone;
    data['area'] = area;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['email'] = email;
    data['birthDate'] = birthDate;
    return data;
  }
}
