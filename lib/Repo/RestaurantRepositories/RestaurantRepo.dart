import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RestaurantRepo {
  final String restaurantLoginURL =
      'http://192.168.0.111:3000/restaurants/login';

  Future<String> authenticate(
      {@required String username, @required String password}) async {
    var client = new http.Client();

    try {
      var response = await client.post(
        restaurantLoginURL,
        body: {'email': username, 'password': password},
      );

      // check if status code is not greater than 300
      if (!(response.statusCode > 300)) {
        return (jsonDecode(response.body)['token']);
      } else {
        throw (jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Future<void> persistToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    return;
  }

  Future<String> retrieveToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
