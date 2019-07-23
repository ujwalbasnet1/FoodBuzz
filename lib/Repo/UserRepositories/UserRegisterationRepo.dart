import 'package:food_buzz/Models/User.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../const.dart';

class UserRegistrationRepo {
  Future<void> register({@required User user}) async {
    final String _registrationURL = Constant.baseURL + 'users';

    print('\n\n\nIn Repository');

    var client = new http.Client();

    try {
      print('\n\n\nIn Repository try-catch');

      var registerResponse =
          await client.post(_registrationURL, body: user.toJSON());

      print('\n\n\nIn Repository try-catch2');

      // check if status code is not greater than 300
      if (!(registerResponse.statusCode > 300)) {
        // _storeRole(isRestaurant);
        // return (jsonDecode(response.body)['message']);
        print(jsonDecode(registerResponse.body)['message']);
      } else {
        return Future.error(jsonDecode(registerResponse.body)['message']);
      }
    } catch (error) {
      return error.toString();
    }
  }
}
