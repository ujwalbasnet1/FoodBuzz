import 'package:food_buzz/Models/Restaurant.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../const.dart';

class RestaurantRegistrationRepo {
  Future<void> register({@required Restaurant restaurant}) async {
    final String _registrationURL = Constant.baseURL + 'restaurants';

    var client = new http.Client();

    try {
      var registerResponse =
          await client.post(_registrationURL, body: restaurant.toJSON());

      // check if status code is not greater than 300
      if (!(registerResponse.statusCode > 300)) {
        // _storeRole(isRestaurant);
        // return (jsonDecode(response.body)['message']);
        print(jsonDecode(registerResponse.body)['message']);
      } else {
        // return Future.error(jsonDecode(response.body)['message']);
        print(jsonDecode(registerResponse.body)['message']);
      }
    } catch (error) {
      return error.toString();
    }
  }
}
