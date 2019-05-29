import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthenticationRepo {
  final String baseURL = 'http://192.168.0.11:3000/';

  String authenticationURL;

  AuthenticationRepo();

  Future<String> authenticate(
      {@required String username,
      @required String password,
      @required bool isRestaurant}) async {
    var client = new http.Client();

    String temp = isRestaurant ? 'restaurants' : 'users';
    authenticationURL = baseURL + temp + '/login';

    try {
      var response = await client.post(
        authenticationURL,
        body: {'email': username, 'password': password},
      );

      // check if status code is not greater than 300
      if (!(response.statusCode > 300)) {
        _storeRole(isRestaurant);
        return (jsonDecode(response.body)['token']);
      } else {
        return Future.error(jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> _storeRole(bool isRestaurant) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('role', isRestaurant);
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('role');
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

  Future<bool> retrieveRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('role');
  }
}
