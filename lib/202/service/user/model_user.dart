class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'username': String username,
        'email': String email,
        'address': Map<String, dynamic>? address,
      } =>
        UserModel(
          id: id,
          name: name,
          username: username,
          email: email,
          address: address != null ? Address.fromJson(address) : null,
        ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}

class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;

  Address({this.street, this.suite, this.city, this.zipcode});

  factory Address.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'street': String street,
        'suite': String suite,
        'city': String city,
        'zipcode': String zipcode,
      } =>
        Address(
          street: street,
          suite: suite,
          city: city,
          zipcode: zipcode,
        ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}
