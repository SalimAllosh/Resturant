class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel(
      {id,
      required addressType,
      contactPersonName,
      required contactPersonNumber,
      required address,
      required latitude,
      required longitude}) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }

  String get address => _address;
  String get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String get contactPersonNumber => _contactPersonNumber;
  String get latitude => _latitude;
  String get longitude => _longitude;

  AddressModel.fromJson(Map<String, dynamic> data) {
    _id = data["id"];
    _addressType = data["address_type"] ?? "";
    _contactPersonNumber = data["contact_person_number"] ?? "";
    _contactPersonName = data["contact_person_name"] ?? "";
    _address = data["address"];
    _latitude = data["latitude"];
    _longitude = data["longitude"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = _id;
    data["address_type"] = _addressType;
    data["contact_person_number"] = _contactPersonNumber;
    data["contact_person_name"] = _contactPersonName;
    data["address"] = _address;
    data["latitude"] = _latitude;
    data["longitude"] = _longitude;
    return data;
  }
}
