import 'dart:io';

import 'package:food_buzz/Models/User.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../const.dart';
import 'package:location/location.dart';

import '../AuthenticationRepo.dart';

class UserRepos {
  Future<void> updateLocation({@required LocationData location}) async {
    final String _registrationURL = Constant.baseURL + 'users/updateLatLng';

    var lat = location.latitude;
    var lng = location.longitude;

    var client = new http.Client();

    try {
      var registerResponse = await client.post(_registrationURL, body: {
        'lat': lat.toString(),
        'lng': lng.toString()
      }, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await AuthenticationRepo().retrieveToken()
      });

      if (!(registerResponse.statusCode > 300)) {
//        print(jsonDecode(registerResponse.body)['message']);
      } else {
        return Future.error(jsonDecode(registerResponse.body)['message']);
      }
    } catch (error) {
      return error.toString();
    }
  }

  Future<User> getProfile() async {
    final String _profileURL = Constant.baseURL + 'users/profile';

    var client = new http.Client();

    try {
      var profileResponse = await client.get(_profileURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await AuthenticationRepo().retrieveToken()
      });

      // check if status code is not greater than 300
      if (!(profileResponse.statusCode > 300)) {
        // return (jsonDecode(response.body)['message']);
        var rawProfileResponse = jsonDecode(profileResponse.body);

        User userProfile = new User(
            id: rawProfileResponse['id'].toString(),
            email: rawProfileResponse['email'],
            name: rawProfileResponse['name'],
            picture: rawProfileResponse['picture'],
            gender: rawProfileResponse['gender'],
            address: rawProfileResponse['address'],
            phoneNumber: rawProfileResponse['phone_number']);

        return userProfile;
      } else {
        return Future.error(jsonDecode(profileResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<User> getProfileByID(String id) async {
    final String _profileURL = Constant.baseURL + 'users/profile/' + id;

    var client = new http.Client();

    try {
      var profileResponse = await client.get(_profileURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await AuthenticationRepo().retrieveToken()
      });

      // check if status code is not greater than 300
      if (!(profileResponse.statusCode > 300)) {
        // return (jsonDecode(response.body)['message']);
        var rawProfileResponse = jsonDecode(profileResponse.body);

        User userProfile = new User(
            id: rawProfileResponse['id'].toString(),
            email: rawProfileResponse['email'],
            name: rawProfileResponse['name'],
            picture: rawProfileResponse['picture'],
            gender: rawProfileResponse['gender'],
            address: rawProfileResponse['address'],
            phoneNumber: rawProfileResponse['phone_number']);

        return userProfile;
      } else {
        return Future.error(jsonDecode(profileResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<dynamic> getNearByRestaurant() async {
    final String _profileURL = Constant.baseURL + 'nearby/restaurants';

    var client = new http.Client();

    try {
      var profileResponse = await client.get(_profileURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await AuthenticationRepo().retrieveToken()
      });

      // check if status code is not greater than 300
      if (!(profileResponse.statusCode > 300)) {
        // return (jsonDecode(response.body)['message']);
        return jsonDecode(profileResponse.body);
      } else {
        return Future.error(jsonDecode(profileResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<dynamic> getNearByUser() async {
    final String _profileURL = Constant.baseURL + 'nearby/users';

    var client = new http.Client();

    try {
      var profileResponse = await client.get(_profileURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await AuthenticationRepo().retrieveToken()
      });

      // check if status code is not greater than 300
      if (!(profileResponse.statusCode > 300)) {
        // return (jsonDecode(response.body)['message']);

        return jsonDecode(profileResponse.body);
      } else {
        return Future.error(jsonDecode(profileResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }
}
