import 'dart:convert';

class FoodItem {
  String id;
  String name;
  String price;
  String picture;

  FoodItem({this.id, this.name, this.price, this.picture});

  FoodItem.fromJSON(String jsonString) {
    var rawData = jsonDecode(jsonString);

    id = rawData['id'];
    name = rawData['name'];
    price = rawData['price'];
    picture = rawData['picture'];
  }

  String toJSON() {
    return '{id: $id, name: $name, price: $price, picture: $picture}';
  }
}
