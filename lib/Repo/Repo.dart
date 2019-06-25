import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../const.dart';

class Repo {
  final String baseURL = Constant.baseURL;

  Future<List<Map<String, String>>> getCategories() async {
    final String categoriesURL = baseURL + 'categories';

    var client = new http.Client();

    try {
      var registerResponse = await client.get(categoriesURL);

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
}
