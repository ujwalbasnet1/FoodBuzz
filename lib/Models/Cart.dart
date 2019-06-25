import 'dart:convert';

import 'FoodItem.dart';

class Cart {
  List<FoodItem> foodItems;
  double totalPrice;

  Cart.fromJSON(String jsonString) {
    var rawData = jsonDecode(jsonString);
    totalPrice = rawData['total_price'];

    for (int i = 0; i < rawData['food_items'].length; i++) {
      FoodItem tempFoodItem = FoodItem.fromJSON(rawData['food_items'][i]);
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
 *      name: 'CCFC',
 *      price: '2000',
 *      picture: 'https://www.dfajskldfjl.jpg'
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
