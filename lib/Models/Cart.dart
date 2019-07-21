import 'dart:convert';

import 'FoodItem.dart';

class CartItemModel {
  FoodItem foodItem;
  int count = 0;

  int cartId;

  CartItemModel() {
    cartId = DateTime.now().millisecondsSinceEpoch;
    count = 1;
  }

  CartItemModel.createNew(FoodItem fooditem) {
    foodItem = fooditem;
    cartId = DateTime.now().millisecondsSinceEpoch;
    count = 1;
  }

  CartItemModel.fromJSON(String jsonString) {
    var rawData = jsonDecode(jsonString);

    cartId = rawData['cartId'];
    count = rawData['count'];
    foodItem.restaurantId = rawData['restaurantId'];
    foodItem.restaurantName = rawData['restaurantName'];
    foodItem.id = rawData['id'];
    foodItem.name = rawData['name'];
    foodItem.price = rawData['price'];
    foodItem.picture = rawData['picture'];
  }

  String toJSON() {
    return '{restaurantId:' +
        foodItem.restaurantId +
        ', id:' +
        foodItem.id +
        ', count:' +
        this.count.toString() +
        ', cartId:' +
        this.cartId.toString() +
        ', restaurantName:' +
        foodItem.restaurantName +
        ', name:' +
        foodItem.name +
        ', price:' +
        foodItem.price +
        ', picture:' +
        foodItem.picture +
        '}';
  }
}

class Cart {
  List<CartItemModel> foodItems;
  double totalPrice;

  Cart() {
    foodItems = [];
    totalPrice = 0;
  }

  Cart.fromJSON(String jsonString) {
    var rawData = jsonDecode(jsonString);
    totalPrice = rawData['total_price'];

    for (int i = 0; i < rawData['food_items'].length; i++) {
      CartItemModel tempFoodItem =
          CartItemModel.fromJSON(rawData['food_items'][i]);
      foodItems.add(tempFoodItem);
    }
  }

  String toJSON() {
    String jsonString = '{';

    double tempTotalPrice = 0;

    jsonString += 'food_items: [';
    for (int i = 0; i < foodItems.length; i++) {
      jsonString += foodItems[i].toJSON();

      // tempTotalPrice += foodItems[i].price;
    }

    jsonString += '],';
    jsonString += 'total_price: $tempTotalPrice,';
    jsonString += '}';
    return jsonString;
  }
}

/**
 * JSON SAMPLE OF CART
 * 
 * {
 *  food_items : [
 *    {
 *      id: 1,
 *      cartId: 5,
 *      restaurantId: 3,
 *      restaurantName: 'Blaba',
 *      name: 'CCFC',
 *      price: '2000',
 *      picture: 'https://www.dfajskldfjl.jpg',
 *      count: 5
 *    },
 *    {
 *      id: 1,
 *      name: 'CCFC',
 *      price: '2000',
 *      picture: 'https://www.dfajskldfjl.jpg'
 *    },
 *  ],
 *  total_price: 4000,
 * }
  
*/
