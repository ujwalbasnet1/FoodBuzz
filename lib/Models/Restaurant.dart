class Restaurant {
  String id;
  String email;
  String password;
  String name;
  String description;
  String address;
  String phoneNumber;
  String lat;
  String lng;
  String picture;
  String coverImg;

  Restaurant(
      {this.id,
      this.email,
      this.password,
      this.name,
      this.description,
      this.address,
      this.phoneNumber,
      this.picture,
      this.coverImg,
      this.lat,
      this.lng});

  dynamic toJSON() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'description': description,
      'address': address,
      'phone_number': phoneNumber,
      'lat': lat,
      'lng': lng
    };
  }
}
