import 'package:food_app/models/address_model.dart';

class userAddressModel {
  AddressModel? home;
  AddressModel? office;
  AddressModel? other;

  userAddressModel({this.home, this.office, this.other});

  userAddressModel.fromJson(Map<String, dynamic> json) {
    home =
        json['home'] != null ? new AddressModel.fromJson(json['home']) : null;
    office = json['office'] != null
        ? new AddressModel.fromJson(json['office'])
        : null;
    other = json['office'] != null
        ? new AddressModel.fromJson(json['office'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.home != null) {
      data['home'] = home!.toJson();
    }
    if (this.office != null) {
      data['office'] = this.office!.toJson();
    }
    if (this.other != null) {
      data['other'] = this.other!.toJson();
    }
    return data;
  }
}
