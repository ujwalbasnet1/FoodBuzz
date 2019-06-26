import 'package:food_buzz/Models/Dish.dart';
import 'package:food_buzz/Models/DishCategories.dart';
import 'package:food_buzz/Models/FoodItem.dart';
import 'package:food_buzz/Models/Restaurant.dart';
import 'package:food_buzz/Repo/AuthenticationRepo.dart';
import 'package:food_buzz/const.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:io';

class RestaurantProfileRepo {
  final AuthenticationRepo authenticationRepo;
  final String baseURL = Constant.baseURL + 'restaurants/';

  final String baseImageURL = Constant.baseURL;

  RestaurantProfileRepo({@required this.authenticationRepo});

  Future<Restaurant> getProfile() async {
    final String _profileURL = baseURL + 'profile';

    var client = new http.Client();

    try {
      var profileResponse = await client.get(_profileURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await authenticationRepo.retrieveToken()
      });

      // check if status code is not greater than 300
      if (!(profileResponse.statusCode > 300)) {
        // return (jsonDecode(response.body)['message']);
        var rawProfileResponse = jsonDecode(profileResponse.body);

        Restaurant restaurantProfile = new Restaurant(
            id: rawProfileResponse['id'].toString(),
            email: rawProfileResponse['email'],
            name: rawProfileResponse['name'],
            picture: baseImageURL + rawProfileResponse['picture'],
            coverImg: baseImageURL + rawProfileResponse['cover_img'],
            address: rawProfileResponse['address'],
            phoneNumber: rawProfileResponse['phone_number']);

        return restaurantProfile;
      } else {
        return Future.error(jsonDecode(profileResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<List<DishCategories>> getCategoriesDishes() async {
    final String _registrationURL = baseURL + 'dish';

    print('\n\n\n\Requested');

    var client = new http.Client();

    try {
      var registerResponse = await client.get(_registrationURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await authenticationRepo.retrieveToken()
      });

      List<DishCategories> categoryList = [];

      // check if status code is not greater than 300
      if (!(registerResponse.statusCode > 300)) {
        Map<String, dynamic> rawData = jsonDecode(registerResponse.body);

        rawData.forEach((String key, dynamic value) {
          DishCategories dishCategories = DishCategories();
          dishCategories.category = key;
          dishCategories.dishes = [];

          for (int i = 0; i < value.length; i++) {
            DishCategoryItem dishCategoryItem = DishCategoryItem(
              id: value[i]['id'].toString(),
              restaurantId: value[i]['restaurant_id'].toString(),
              name: value[i]['name'].toString(),
              price: value[i]['price'].toString(),
              picture: value[i]['picture'].toString(),
              categoryId: value[i]['category_id'].toString(),
            );

            dishCategories.dishes.add(dishCategoryItem);
          }

          categoryList.add(dishCategories);
        });

        return categoryList;
      } else {
        // return Future.error(jsonDecode(response.body)['message']);
        throw Future.error(jsonDecode(registerResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<List<Map<String, String>>> getCategories() async {
    final String _registrationURL = baseURL + 'categories';

    var client = new http.Client();

    try {
      var registerResponse = await client.get(_registrationURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await authenticationRepo.retrieveToken()
      });

      List<Map<String, String>> categoryList = [];

      // check if status code is not greater than 300
      if (!(registerResponse.statusCode > 300)) {
        var rawData = jsonDecode(registerResponse.body);

        for (int i = 0; i < rawData.length; i++) {
          categoryList.add({rawData[i]['id'].toString(): rawData[i]['name']});
        }
        return categoryList;
      } else {
        // return Future.error(jsonDecode(response.body)['message']);
        throw Future.error(jsonDecode(registerResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<List<FoodItem>> getItems({@required String categoryId}) async {
    final String _registrationURL = baseURL + 'category/' + categoryId;

    var client = new http.Client();

    try {
      var registerResponse = await client.get(_registrationURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await authenticationRepo.retrieveToken()
      });

      List<FoodItem> list = [];

      // check if status code is not greater than 300
      if (!(registerResponse.statusCode > 300)) {
        // _storeRole(isRestaurant);
        // return (jsonDecode(response.body)['message']);
        var rawData = jsonDecode(registerResponse.body);

        for (int i = 0; i < rawData.length; i++) {
          FoodItem foodItem = new FoodItem(
              id: rawData[i]['id'].toString(),
              name: rawData[i]['name'],
              price: rawData[i]['price'].toString(),
              picture: rawData[i]['picture']);
          list.add(foodItem);
        }

        return list;
      } else {
        // return Future.error(jsonDecode(response.body)['message']);
        throw Future.error(jsonDecode(registerResponse.body)['message']);
      }
    } catch (error) {
      throw Future.error(error.toString());
    }
  }

  Future<String> addDish({@required Dish dish}) async {
    var client = new http.Client();

    try {
      var response = await client.post(baseURL + 'dish', body: {
        'picture': dish.imageURL,
        'name': dish.name,
        'price': dish.price,
        'categories': dish.categories
      }, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await authenticationRepo.retrieveToken()
      });

      // check if status code is not greater than 300
      if (!(response.statusCode > 300)) {
        return (jsonDecode(response.body)['message']);
      } else {
        return Future.error(jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return error.toString();
    }
  }
}
