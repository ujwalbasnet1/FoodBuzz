import 'dart:convert';

class FoodItem {
  String id;
  String name;
  String price;
  String picture;
  String restaurantId;
  String restaurantName;

  FoodItem(
      {this.restaurantId,
      this.restaurantName,
      this.id,
      this.name,
      this.price,
      this.picture});

  FoodItem.fromJSON(String jsonString) {
    var rawData = jsonDecode(jsonString);

    restaurantId = rawData['restaurantId'];
    id = rawData['id'];
    name = rawData['name'];
    price = rawData['price'];
    picture = rawData['picture'];
  }

  String toJSON() {
    return '{restaurantId: $restaurantId, id: $id, name: $name, price: $price, picture: $picture}';
  }
}
