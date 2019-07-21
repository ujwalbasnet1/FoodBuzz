import 'dart:io';

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../const.dart';
import '../AuthenticationRepo.dart';

class SearchRepo {
  Future<dynamic> search({@required String searchText}) async {
    final String _searchURL = Constant.baseURL + 'search/' + searchText;

    var client = new http.Client();

    try {
      var registerResponse = await client.get(_searchURL, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ' + await AuthenticationRepo().retrieveToken()
      });

      // check if status code is not greater than 300
      if (!(registerResponse.statusCode > 300)) {
        // _storeRole(isRestaurant);
        // return (jsonDecode(response.body)['message']);
        var rawData = jsonDecode(registerResponse.body);

        // dishes
        return rawData;
      } else {
        // return Future.error(jsonDecode(response.body)['message']);
        print(jsonDecode(registerResponse.body)['message']);
      }
    } catch (error) {
      print(error);
      return error.toString();
    }
  }
}
