class User {
  String id;
  String name;
  String email;
  String password;
  String gender;
  String address;
  String phoneNumber;
  String picture;
  String lat;
  String lng;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.gender,
    this.address,
    this.phoneNumber,
    this.picture,
    this.lat,
    this.lng,
  });

  dynamic toJSON() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'gender': gender,
      'address': address,
      'phone_number': phoneNumber,
    };
  }
}
