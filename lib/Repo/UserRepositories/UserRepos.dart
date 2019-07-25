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
          phoneNumber: rawProfileResponse['phone_number'],
          following: rawProfileResponse['following'],
        );

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

  Future<String> followUser(String id) async {
    final String _profileURL = Constant.baseURL + 'follow/' + id;

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

        return rawProfileResponse.toString();
      } else {
        return Future.error(jsonDecode(profileResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<void> order(dynamic cart) async {
    final String _profileURL = Constant.baseURL + 'order';

    var client = new http.Client();

    try {
      var profileResponse =
          await client.post(_profileURL, body: cart, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await AuthenticationRepo().retrieveToken()
      });

      // check if status code is not greater than 300
      if (!(profileResponse.statusCode > 300)) {
        // return (jsonDecode(response.body)['message']);
        var rawProfileResponse = jsonDecode(profileResponse.body);

//        return rawProfileResponse.toString();
      } else {
        return Future.error(jsonDecode(profileResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<void> like(int id) async {
    final String _profileURL = Constant.baseURL + 'like/' + id.toString();

    var client = new http.Client();

    try {
      var profileResponse = await client.get(_profileURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await AuthenticationRepo().retrieveToken()
      });

      if (!(profileResponse.statusCode > 300)) {
        var rawProfileResponse = jsonDecode(profileResponse.body);
        print(rawProfileResponse);
      } else {
        return Future.error(jsonDecode(profileResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<List<FeedItemModel>> feeds() async {
    final String _profileURL = Constant.baseURL + 'feeds';

    var client = new http.Client();

    try {
      var profileResponse = await client.get(_profileURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await AuthenticationRepo().retrieveToken()
      });

      // check if status code is not greater than 300
      if (!(profileResponse.statusCode > 300)) {
        // return (jsonDecode(response.body)['message']);
        var rawResponse = jsonDecode(profileResponse.body);

        List<FeedItemModel> postList = [];

        for (int i = 0; i < rawResponse.length; i++) {
          postList.add(FeedItemModel(
            id: rawResponse[i]['id'],
            orderPackageID: rawResponse[i]['order_package_id'],
            userID: rawResponse[i]['user_id'],
            restaurantID: rawResponse[i]['restaurant_id'],
            dishID: rawResponse[i]['dish_id'],
            likes: rawResponse[i]['likes'],
            liked: rawResponse[i]['liked'],
            name: rawResponse[i]['name'],
            time: rawResponse[i]['time'],
            dishPicture: rawResponse[i]['dish_picture'],
            dishName: rawResponse[i]['dish_name'],
            profilePicture: rawResponse[i]['profile_picture'],
          ));
        }

        return postList;
      } else {
        return Future.error(jsonDecode(profileResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<List<FeedItemModel>> friendFeeds(String id) async {
    print('ID' + id);
    final String _profileURL = Constant.baseURL + 'feeds/' + id;

    var client = new http.Client();

    try {
      var profileResponse = await client.get(_profileURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await AuthenticationRepo().retrieveToken()
      });

      // check if status code is not greater than 300
      if (!(profileResponse.statusCode > 300)) {
        // return (jsonDecode(response.body)['message']);
        var rawResponse = jsonDecode(profileResponse.body);

        print('\n\n\nFriendFeed' + rawResponse.toString());

        List<FeedItemModel> postList = [];

        for (int i = 0; i < rawResponse.length; i++) {
          postList.add(FeedItemModel(
            id: rawResponse[i]['id'],
            orderPackageID: rawResponse[i]['order_package_id'],
            userID: rawResponse[i]['user_id'],
            restaurantID: rawResponse[i]['restaurant_id'],
            dishID: rawResponse[i]['dish_id'],
            likes: rawResponse[i]['likes'],
            liked: rawResponse[i]['liked'],
            name: rawResponse[i]['name'],
            time: rawResponse[i]['time'],
            dishPicture: rawResponse[i]['dish_picture'],
            dishName: rawResponse[i]['dish_name'],
            profilePicture: rawResponse[i]['profile_picture'],
          ));
        }

        return postList;
      } else {
        return Future.error(jsonDecode(profileResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<List<FeedItemModel>> myFeeds() async {
    final String _profileURL = Constant.baseURL + 'myFeed';

    var client = new http.Client();

    try {
      var profileResponse = await client.get(_profileURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await AuthenticationRepo().retrieveToken()
      });

      // check if status code is not greater than 300
      if (!(profileResponse.statusCode > 300)) {
        // return (jsonDecode(response.body)['message']);
        var rawResponse = jsonDecode(profileResponse.body);

        List<FeedItemModel> postList = [];

        for (int i = 0; i < rawResponse.length; i++) {
          postList.add(FeedItemModel(
            id: rawResponse[i]['id'],
            orderPackageID: rawResponse[i]['order_package_id'],
            userID: rawResponse[i]['user_id'],
            restaurantID: rawResponse[i]['restaurant_id'],
            dishID: rawResponse[i]['dish_id'],
            likes: rawResponse[i]['likes'],
            liked: rawResponse[i]['liked'],
            name: rawResponse[i]['name'],
            time: rawResponse[i]['time'],
            dishPicture: rawResponse[i]['dish_picture'],
            dishName: rawResponse[i]['dish_name'],
            profilePicture: rawResponse[i]['profile_picture'],
          ));
        }

        postList.forEach((p) {
          print(p);
        });

        return postList;
      } else {
        return Future.error(jsonDecode(profileResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<List<RecommendationItemModel>> myRecommendations() async {
    final String _profileURL = Constant.baseURL + 'recommendations';

    var client = new http.Client();

    try {
      var profileResponse = await client.get(_profileURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await AuthenticationRepo().retrieveToken()
      });

      // check if status code is not greater than 300
      if (!(profileResponse.statusCode > 300)) {
        // return (jsonDecode(response.body)['message']);
        var rawResponse = jsonDecode(profileResponse.body);

        List<RecommendationItemModel> recommendedList = [];

        for (int i = 0; i < rawResponse.length; i++) {
          recommendedList.add(RecommendationItemModel(
            id: rawResponse[i]['id'],
            restaurantID: rawResponse[i]['restaurant_id'],
            price: rawResponse[i]['price'].toString(),
            picture: rawResponse[i]['picture'],
            name: rawResponse[i]['name'],
            restaurantName: rawResponse[i]['restaurant_name'],
          ));
        }

        return recommendedList;
      } else {
        return Future.error(jsonDecode(profileResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }
}

class RecommendationItemModel {
  int id;
  int restaurantID;
  String price;
  String picture;
  String name;
  String restaurantName;

  RecommendationItemModel({
    this.id,
    this.restaurantID,
    this.price,
    this.picture,
    this.name,
    this.restaurantName,
  });
}

class FeedItemModel {
  int id;
  int orderPackageID;
  int userID;
  int restaurantID;
  int dishID;
  int likes;
  bool liked;
  String name;
  String time;
  String dishPicture;
  String dishName;
  String profilePicture;

  FeedItemModel({
    this.id,
    this.orderPackageID,
    this.userID,
    this.restaurantID,
    this.dishID,
    this.name,
    this.time,
    this.likes,
    this.liked,
    this.dishPicture,
    this.dishName,
    this.profilePicture,
  });
}
